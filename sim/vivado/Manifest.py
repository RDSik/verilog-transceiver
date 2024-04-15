import shutil
from pathlib import Path

action = "simulation"
sim_tool = "vivado_sim"
sim_top = "transceiver_tb"

sim_post_cmd = "xsim %s -gui" % sim_top

modules = {
    "local" : [ 
        "../../top/tb/",
    ],
}

dat_files = Path("../")

shutil.copyfile(dat_files / 'neg_sin_value.dat', 'neg_sin_value.dat')
shutil.copyfile(dat_files / 'sin_value.dat', 'sin_value.dat')