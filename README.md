# Usage

## Dependencies 

`hdlmake`, `make`, `vivado`, `python`

## Clone repository:
```bash
git clone https://github.com/RDSik/FPGA_transceiver.git
cd FPGA_trasceiver
```

## Requirements installation:
```bash
pip install six
pip install hdlmake
winget install GnuWin32.make # add to PATH system variable the Make bin folder: C:\Program Files (x86)\GnuWin32\bin
```

## Build FPGA_trasceiver:
```bash
cd syn
hdlmake
make # make project create only Vivado project
```

## FPGA_trasceiver test

```bash
cd sim
hdlmake
make
vsim work.transceiver_tb
```
