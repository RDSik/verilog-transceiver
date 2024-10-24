import cocotb
import random
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge, FallingEdge, ClockCycles
from cocotb.utils import get_sim_time

clk_per     = 2
clk_per_bit = 8
data_width  = 8

class Test:
    def __init__(self, dut):
        self.dut = dut
        dut.arstn.setimmediatevalue(0)
        dut.en.setimmediatevalue(0)
        cocotb.start_soon(Clock(self.dut.clk, clk_per, units = 'sec').start())

    async def init(self, n):
        await self.reset(clk_per)
        for i in range(n):
            await self.data_gen()
            await Timer(clk_per*1000, units='sec')

    async def reset(self, cycles):
        self.dut.arstn.value = 0
        await ClockCycles(self.dut.clk, cycles)
        self.dut.arstn.value = 1

    async def data_gen(self):
        print('------------------------------------------------------------')
        print(f'Data generation cycle start in {get_sim_time('ns')} ns.')
        print('------------------------------------------------------------')
        self.dut.en.value = 1
        await Timer(clk_per, units='sec')
        self.dut.data.value = 0
        print(f'Start bit detected in {get_sim_time('ns')} ns.')
        await Timer(int(clk_per_bit/2*clk_per), units='sec') # start bit wait
        print(f'Data transmission start in {get_sim_time('ns')} ns.')
        for bit in range (data_width):
            await Timer(clk_per_bit*clk_per, units='sec') # data transmit
            self.dut.data.value = random.randint(0, 1)
            print(f'{bit} bit detected in {get_sim_time('ns')} ns.')
        await Timer(clk_per, units='sec') # stop bit wait
        self.dut.data.value = 1
        print(f'Stop bit detected in {get_sim_time('ns')} ns.')
        await Timer(clk_per_bit*clk_per, units='sec')


@cocotb.test()
async def run_test(dut):
    
    #------------------Order of test execution -------------------
    tb = Test(dut)
    await tb.init(10)
