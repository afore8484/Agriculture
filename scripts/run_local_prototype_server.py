#!/usr/bin/env python3
"""
Serve the cloned Figma prototype locally with SPA history fallback.

Default root:
  scripts/figma_crawler/output
"""

from __future__ import annotations

import argparse
import mimetypes
import posixpath
from http import HTTPStatus
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from urllib.parse import unquote, urlparse


DEFAULT_ROOT = Path(__file__).resolve().parent / "figma_crawler" / "output"


class SPARouteHandler(SimpleHTTPRequestHandler):
    def __init__(self, *args, directory: str, **kwargs):
        super().__init__(*args, directory=directory, **kwargs)

    def _normalized_url_path(self, path: str) -> str:
        path = urlparse(path).path
        path = posixpath.normpath(unquote(path))
        if path.startswith("/_json/"):
            # Runtime expects /_json, crawler saved under /json/_json
            path = "/json" + path
        return path

    def translate_path(self, path: str) -> str:
        path = self._normalized_url_path(path)
        parts = [p for p in path.split("/") if p]
        local_path = Path(self.directory)
        for part in parts:
            if part in (".", ".."):
                continue
            local_path = local_path / part
        return str(local_path)

    def do_GET(self) -> None:
        normalized = self._normalized_url_path(self.path)
        requested = Path(self.translate_path(self.path))

        if requested.exists():
            return super().do_GET()

        # Runtime expects JSON; returning HTML error pages causes:
        # "Unexpected token '<' ... is not valid JSON".
        if normalized.endswith(".json"):
            if "/_cms/" in normalized:
                # Optional CMS JSON: empty object is sufficient for local preview.
                payload = b"{}"
                self.send_response(HTTPStatus.OK)
            else:
                # Non-CMS missing JSON: keep 404 semantics, but return JSON body.
                payload = b'{"error":"not_found","path":"%s"}' % normalized.encode(
                    "utf-8", errors="ignore"
                )
                self.send_response(HTTPStatus.NOT_FOUND)
            self.send_header("Content-Type", "application/json; charset=utf-8")
            self.send_header("Content-Length", str(len(payload)))
            self.end_headers()
            self.wfile.write(payload)
            return

        # If request looks like a file/resource path, return 404 instead of index fallback.
        suffix = Path(normalized).suffix
        if suffix:
            self.send_error(HTTPStatus.NOT_FOUND, "File not found")
            return

        # SPA fallback only for route-like paths (no extension).
        index_file = Path(self.directory) / "index.html"
        if index_file.exists():
            self.path = "/index.html"
            return super().do_GET()

        self.send_error(HTTPStatus.NOT_FOUND, "File not found")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Run local prototype server")
    parser.add_argument("--host", default="127.0.0.1", help="Bind host")
    parser.add_argument("--port", type=int, default=8000, help="Bind port")
    parser.add_argument(
        "--root",
        default=str(DEFAULT_ROOT),
        help="Prototype root directory",
    )
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    root = Path(args.root).resolve()
    if not root.exists():
        raise SystemExit(f"Prototype root does not exist: {root}")
    if not (root / "index.html").exists():
        raise SystemExit(f"index.html not found under root: {root}")

    # Ensure JSON has expected content-type in some Windows environments.
    mimetypes.add_type("application/json", ".json")

    server = ThreadingHTTPServer(
        (args.host, args.port),
        lambda *a, **kw: SPARouteHandler(*a, directory=str(root), **kw),
    )
    print(f"Serving prototype at http://{args.host}:{args.port}")
    print(f"Root: {root}")
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        server.server_close()


if __name__ == "__main__":
    main()


