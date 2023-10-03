target = "xilinx"

action = "synthesis"

syn_device = "xc7z020clg484"
syn_grade = "-1"
syn_package = ""
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
