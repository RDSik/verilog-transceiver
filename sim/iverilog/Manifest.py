import shutil
from pathlib import Path

action = "simulation"
sim_tool = "iverilog"
sim_top = "transceiver_tb"

sim_post_cmd = "vvp transceiver_tb.vvp; gtkwave transceiver_tb.vcd"

modules = {
    "local" : [ 
        "../../top/tb/",
    ],
}

dat_files_path = Path("../../syn")

shutil.copyfile(dat_files_path / 'neg_sin_val.dat', 'neg_sin_val.dat')
shutil.copyfile(dat_files_path / 'sin_val.dat', 'sin_val.dat')