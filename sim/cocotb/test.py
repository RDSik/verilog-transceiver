import os
import shutil
from pathlib import Path

import cocotb
from cocotb.runner import get_runner

def test_runner():
    src = Path("../../")
    
    hdl_toplevel_lang = os.getenv("HDL_TOPLEVEL_LANG", "verilog")
    sim = os.getenv("SIM", "icarus")
    
    build_dir = Path('sim_build_transceiver')
    build_dir.mkdir(exist_ok=True)

    dat_files_path = Path("../../syn")

    shutil.copyfile(dat_files_path / 'neg_sin_val.dat', build_dir / 'neg_sin_val.dat')
    shutil.copyfile(dat_files_path / 'sin_val.dat', build_dir / 'sin_val.dat')

    verilog_sources = []
    
    def files(path):
        sources = []
        for (dirpath, _, files) in os.walk(path):
            for file in files:
                if file != 'Manifest.py':
                    sources.append(dirpath.replace("\\", '/') +'/' + file)
            return sources

    verilog_sources.extend(files(src))
    
    hdl_toplevel = 'transceiver_top' # HDL module name
    test_module = 'transceiver_tb' # Python module name

    runner = get_runner(sim)
    
    runner.build(
        verilog_sources=verilog_sources,
        hdl_toplevel=hdl_toplevel,
        build_dir=build_dir,
        always=True, # Always rebuild project
    )

    runner.test(
        hdl_toplevel=hdl_toplevel,
        test_module=test_module,
        waves=True,
        gui=True,
    )
    
