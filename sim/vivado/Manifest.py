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

dat_files_path = Path("../../top")

shutil.copyfile(dat_files_path / 'neg_sin_val.dat', 'neg_sin_val.dat')
shutil.copyfile(dat_files_path / 'sin_val.dat', 'sin_val.dat')