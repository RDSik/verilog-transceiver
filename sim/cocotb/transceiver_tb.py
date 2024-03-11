import cocotb
import random
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge, FallingEdge, ClockCycles

@cocotb.test()
async def test_transceiver(dut):

    cocotb.start_soon(Clock(dut.clk, 2, units = 'ns').start())

    # Reset and enable module
    await FallingEdge(dut.clk)
    dut.rst_n.value = 0
    dut.en.value = 0
    await Timer(2, units="ns")
    dut.rst_n.value = 1
    dut.en.value = 1
    await RisingEdge(dut.clk)

    # Input data module
    for i in range(25000):
        dut.data.value = random.randint(0, 1)
        print(f"data={dut.data}, active={dut.active}, done={dut.done}, q={dut.q}")
        await Timer(1, units="ns")