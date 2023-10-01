target = "xilinx"

action = "synthesis"

syn_device = "xc7z020clg484-1"
syn_package = ""
syn_grade = "-3"
syn_top = "transceiver_top"
syn_project = "transceiver"
syn_tool = "vivado"

files = [
    'transceiver.xdc'
]

modules = {
    "local" : [
        "../",
    ],
}
