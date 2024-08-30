import cocotb
import random
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge, FallingEdge, ClockCycles
from cocotb.utils import get_sim_time

clk_per     = 2
clk_per_bit = 8

async def reset(dut, cycles):
    dut.arstn.value = 0
    await ClockCycles(dut.clk, cycles*clk_per)
    dut.arstn.value = 1

async def data_gen(dut):
    print('------------------------------------------------------------')
    print(f'Data generation cycle start in {get_sim_time('ns')} ns.')
    print('------------------------------------------------------------')
    dut.en.value = 1
    await Timer(clk_per, units='ns')
    dut.data.value = 0
    print(f'Start bit detected in {get_sim_time('ns')} ns.')
    await Timer(int(clk_per_bit/2*clk_per), units='ns') # start bit wait
    print(f'Data transmission start in {get_sim_time('ns')} ns.')
    for bit in range (8):
        await Timer(clk_per_bit*clk_per, units='ns') # data transmit
        dut.data.value = random.randint(0, 1)
        print(f'{bit} bit detected in {get_sim_time('ns')} ns.')
    await Timer(clk_per_bit*clk_per, units='ns') # stop bit wait
    print(f'Stop bit detected in {get_sim_time('ns')} ns.')

async def init(dut, n):

    cocotb.start_soon(Clock(dut.clk, clk_per, units = 'ns').start())

    dut.en.value = 0
    await reset(dut, 1)
    for i in range(n):
        await data_gen(dut)
        await Timer(clk_per*1000, units='ns')

@cocotb.test()
async def test_transceiver(dut):

    #------------------Order of test execution -------------------
    await init(dut, 10)
