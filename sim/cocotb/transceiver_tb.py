import cocotb
import random
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge, FallingEdge, ClockCycles

@cocotb.test()
async def test_transceiver(dut):

    cocotb.start_soon(Clock(dut.clk, 2, units = 'sec').start())

    # Reset and enable module
    await FallingEdge(dut.clk)
    dut.arstn.value = 0
    dut.en.value = 0
    await Timer(2, units="sec")
    dut.arstn.value = 1
    dut.en.value = 1
    await RisingEdge(dut.clk)

    # Input data module
    for i in range(25000):
        dut.data.value = random.randint(0, 1)
        print(f"uart_rx_out={dut.uart_rx_out}, encoder_out={dut.encoder_out}, decoder_out={dut.decoder_out}, demodulator_out={dut.demodulator_out}, active={dut.active}, data_valid={dut.data_valid}, done={dut.done}")
        await Timer(1, units="sec")