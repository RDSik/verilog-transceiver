import cocotb
import random
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge, FallingEdge, ClockCycles
from cocotb.utils import get_sim_time

clk_per     = 2
clk_per_bit = 8

async def reset(dut, cycles):
    dut.arstn.value = 0
    await ClockCycles(dut.clk, cycles)
    dut.arstn.value = 1

async def data_gen(dut, n):
    for i in range(n):
        dut.en.value = 1
        dut.data.value = 0
        await ClockCycles(dut.clk, int((clk_per_bit-1)/2)) # start bit detect
        print(f'Start bit detected in {get_sim_time('ns')} ns.')
        for bit in range (8):
            await ClockCycles(dut.clk, clk_per_bit-1) # data transmit
            dut.data.value = random.randint(0, 1)
            print(f'{bit} bit detected in {get_sim_time('ns')} ns.')
        await ClockCycles(dut.clk,clk_per_bit-1) # stop bit wait
        print(f'Stop bit detected in {get_sim_time('ns')} ns.')
        dut.en.value = 0
        await Timer(clk_per, units='sec')

@cocotb.test()
async def test_transceiver(dut):
    
    cocotb.start_soon(Clock(dut.clk, clk_per, units = 'sec').start())

    #------------------Order of test execution -------------------
    dut.en.value = 0
    await reset(dut, 1)
    await RisingEdge(dut.clk)
    await data_gen(dut, 150)
