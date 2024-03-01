action = "simulation"
sim_tool = "vivado_sim"
sim_top = "transceiver_tb"

sim_post_cmd = "xsim %s -gui" % sim_top

modules = {
    "local" : [ 
        "../../tb/",
    ],
}