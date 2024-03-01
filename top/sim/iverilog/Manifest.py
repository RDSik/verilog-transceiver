action = "simulation"
sim_tool = "iverilog"
sim_top = "transceiver_tb"

sim_post_cmd = "vvp tranceiver_tb.vvp; gtkwave out.vcd"

modules = {
    "local" : [ 
        "../../tb/",
    ],
}
