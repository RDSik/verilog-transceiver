import shutil
from pathlib import Path

action = "simulation"
sim_tool = "modelsim"
sim_top = "transceiver_tb"

sim_post_cmd = "vsim -do wave.do -i transceiver_tb"

modules = {
    "local" : [ 
        "../../top/tb/",
    ],
}

dat_files_path = Path("../../top")

shutil.copyfile(dat_files_path / 'neg_sin_val.dat', 'neg_sin_val.dat')
shutil.copyfile(dat_files_path / 'sin_val.dat', 'sin_val.dat')