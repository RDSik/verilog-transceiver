target = "xilinx"

action = "synthesis"

syn_device = "xc7z020clg484-1"
syn_package = ""
syn_grade = "-3"
syn_top = "receiver_top"
syn_project = "receiver"
syn_tool = "vivado"

files = [
    'receiver.xdc'
]

modules = {
    "local" : [
        "../",
    ],
}
