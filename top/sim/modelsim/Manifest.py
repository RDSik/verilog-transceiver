action = "simulation"
sim_tool = "modelsim"
sim_top = "transceiver_tb"

sim_post_cmd = "vsim -do vsim.do -i transceiver_tb"

modules = {
    "local" : [ 
        "../../tb/",
    ],
}
