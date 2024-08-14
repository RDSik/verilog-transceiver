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

    verilog_sources = [
        src / "top/transceiver_top.v",
        src / "modules/bpsk/sin_generator.v",
        src / "modules/bpsk/bpsk_modulator.v",
        src / "modules/bpsk/bpsk_demodulator.v",
        src / "modules/hamming/hamming_decoder.v",
        src / "modules/hamming/hamming_encoder.v",
        src / "modules/uart/UART/Verilog/source/UART_RX.v",
        src / "modules/uart/UART/Verilog/source/UART_TX.v",
    ]
    
    hdl_toplevel = 'transceiver_top' # HDL module name
    test_module = 'transceiver_tb' # Python module name
    # pre_cmd = ['do wave.do'] # Macro file

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
        # pre_cmd=pre_cmd,
    )
    
