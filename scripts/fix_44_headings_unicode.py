from pathlib import Path
from docx import Document

p = Path(r"E:\workspaces\Agriculture\prototype\output\doc\spec_analysis_draft_v1.docx")
doc = Document(p)
replacements = {
    "4.4.1": "4.4.1 \u91c7\u96c6\u8303\u56f4",
    "4.4.2": "4.4.2 \u6570\u636e\u6e90\u4e0e\u63a5\u5165\u8981\u6c42",
    "4.4.3": "4.4.3 \u91c7\u96c6\u7b56\u7565",
    "4.4.4": "4.4.4 \u6570\u636e\u6e05\u6d17\u4e0e\u8d28\u91cf\u63a7\u5236\u89c4\u5219",
}
for para in doc.paragraphs:
    t = para.text.strip()
    for prefix, value in replacements.items():
        if t.startswith(prefix):
            para.text = value.encode('utf-8').decode('unicode_escape') if '\\u' in value else value
            break
doc.save(p)
print('fixed')
