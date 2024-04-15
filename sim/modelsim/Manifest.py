import shutil
from pathlib import Path

action = "simulation"
sim_tool = "modelsim"
sim_top = "transceiver_tb"

sim_post_cmd = "vsim -do vsim.do -i transceiver_tb"

modules = {
    "local" : [ 
        "../../top/tb/",
    ],
}

dat_files = Path("../")

shutil.copyfile(dat_files / 'neg_sin_value.dat', 'neg_sin_value.dat')
shutil.copyfile(dat_files / 'sin_value.dat', 'sin_value.dat')