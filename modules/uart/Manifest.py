files = []

def list_files(path):
    import os
    files = []
    for (dirpath, _, filenames) in os.walk(path):
        for file in filenames:
            files.append(dirpath.replace("\\", '/') +'/' + file)
    return files

files.extend(list_files("UART/Verilog/source"))