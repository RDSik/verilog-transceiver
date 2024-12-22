<div align="center">

[![Icarus Simulation](https://github.com/RDSik/verilog-transceiver/actions/workflows/main.yml/badge.svg?branch=master)](https://github.com/RDSik/verilog-transceiver/actions/workflows/main.yml)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/RDSik/verilog-transceiver/blob/master/LICENSE.txt)

</div><br/><br/>

![My Image](img/transeiver.drawio.png)

# Usage

## Dependencies 

`hdlmake`, `make`, `cocotb`, `pytest`, `vivado`, `modelsim`, `python`, `chocolatey`, `winget`

## Installation

### Download python and git:
- [Install Chocolatey on Windows 10](https://gist.github.com/lopezjurip/2a188c90284bf239197b)

### Clone repository:
```bash
git clone --recurse-submodules https://github.com/RDSik/verilog-transceiver.git
cd verilog-transceiver
```

### Download packages:
```bash
pip install six
pip install hdlmake
pip install cocotb
pip install pytest
```

### Download make (add to PATH system variable the Make bin folder: C:\Program Files (x86)\GnuWin32\bin):
```bash
winget install GnuWin32.make
```

## Build project

### Build trasceiver:
```bash
cd syn
py -m hdlmake
make
vivado .\transceiver.xpr
```

### Build only vivado project:
```bash
cd syn
py -m hdlmake
make project
vivado .\transceiver.xpr
```

## Simulation

### Modelsim simulation

#### Using hdlmake:
```bash
cd sim/modelsim
py -m hdlmake
make
```

#### Using cocotb (with 64 bit Python use 64 bit Modelsim):
```bash
py -m venv myenv
.\myenv\Scripts\activate.ps1
cd .\sim\cocotb
py -m pytest test.py
deactivate
```

### Icarus simulation:
```bash
cd top
make
```
