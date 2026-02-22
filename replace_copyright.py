import os
import re

count = 0
for root, dirs, files in os.walk("."):
    if ".git" in root or ".idea" in root or ".gradle" in root or "build" in root:
        continue
    for file in files:
        if file.endswith((".java", ".kt", ".xml", ".gradle", ".md", ".properties")):
            path = os.path.join(root, file)
            try:
                with open(path, "r", encoding="utf-8") as f:
                    content = f.read()
                new_content = re.sub(r'Copyright \d{4} Roberto Leinardi', r'Copyright 2024 Its-Chandan', content)
                new_content = new_content.replace('leinardi/FloatingActionButtonSpeedDial', 'Its-Chandan/FloatingActionButtonSpeedDial')
                new_content = new_content.replace('Roberto Leinardi', 'Its-Chandan')
                new_content = new_content.replace('roberto.leinardi@gmail.com', '') 
                
                if new_content != content:
                    with open(path, "w", encoding="utf-8", newline='') as f:
                        f.write(new_content)
                    count += 1
            except Exception as e:
                print(f"Failed {path}")

print(f"Replaced copyright in {count} files")
