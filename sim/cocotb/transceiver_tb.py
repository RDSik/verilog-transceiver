import cocotb
import random
import logging
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge, FallingEdge, ClockCycles
from cocotb.utils import get_sim_time

clk_per     = 2
clk_per_bit = 8
data_width  = 8

class Test:
    def __init__(self, dut):
        self.dut = dut

        self.log = logging.getLogger('cocotb.tb')
        self.log.setLevel(logging.DEBUG)

        dut.arstn.setimmediatevalue(0)
        dut.en.setimmediatevalue(0)

        cocotb.start_soon(Clock(self.dut.clk, clk_per, units = 'ns').start())

    async def init(self, n):
        await self.reset(clk_per)
        for i in range(n):
            await self.data_gen()
            await Timer(clk_per*1000, units='ns')

    async def reset(self, cycles):
        self.dut.arstn.value = 0
        await ClockCycles(self.dut.clk, cycles)
        self.dut.arstn.value = 1

    async def data_gen(self):
        self.dut.log.info(f'Data generation cycle start in {get_sim_time('ns')} ns.')
        self.dut.en.value = 1
        await Timer(clk_per, units='ns')
        self.dut.data.value = 0
        self.dut.log.info(f'Start bit detected in {get_sim_time('ns')} ns.')
        await Timer(int(clk_per_bit/2*clk_per), units='ns') # start bit wait
        self.dut.log.info(f'Data transmission start in {get_sim_time('ns')} ns.')
        for bit in range (data_width):
            await Timer(clk_per_bit*clk_per, units='ns') # data transmit
            self.dut.data.value = random.randint(0, 1)
            self.dut.log.info(f'{bit} bit detected in {get_sim_time('ns')} ns.')
        await Timer(clk_per, units='ns') # stop bit wait
        self.dut.data.value = 1
        self.dut.log.info(f'Stop bit detected in {get_sim_time('ns')} ns.')
        await Timer(clk_per_bit*clk_per, units='ns')


@cocotb.test()
async def run_test(dut):
    
    #------------------Order of test execution -------------------
    tb = Test(dut)
    await tb.init(10)
