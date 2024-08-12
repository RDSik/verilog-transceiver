import os

src = "UART/Verilog/source"

files = []

def files(path):
    files = []
    for (dirpath, _, files) in os.walk(path):
        for file in files:
            files.append(dirpath.replace("\\", '/') +'/' + file)
    return files

files.extend(files(src))
