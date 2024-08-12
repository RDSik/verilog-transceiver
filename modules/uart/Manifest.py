from pathlib import Path

src = Path("UART/Verilog/source")

files = []

def files_list(path):
    import os
    files = []
    for (dirpath, _, file) in os.walk(path):
        for f in file:
            files.append(dirpath.replace("\\", '/') +'/' + f)
    return files

files.extend(files_list(src))
