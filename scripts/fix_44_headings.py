from pathlib import Path
from docx import Document

p = Path(r"E:\workspaces\Agriculture\prototype\output\doc\spec_analysis_draft_v1.docx")
doc = Document(p)
replacements = {
    "4.4.1": "4.4.1 ????",
    "4.4.2": "4.4.2 ????????",
    "4.4.3": "4.4.3 ????",
    "4.4.4": "4.4.4 ???????????",
}
for para in doc.paragraphs:
    t = para.text.strip()
    for prefix, value in replacements.items():
        if t.startswith(prefix):
            para.text = value
            break
doc.save(p)
print("fixed headings")
