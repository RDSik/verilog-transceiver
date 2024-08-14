from pathlib import Path

src = Path("UART/Verilog/source")

files = []

def files_list(path):
    import os
    files = []
    for (dirpath, dirnames, filenames) in os.walk(path):
        for file in filenames:
            files.append(dirpath.replace("\\", '/') +'/' + file)
    return files

files.extend(files_list(src))
