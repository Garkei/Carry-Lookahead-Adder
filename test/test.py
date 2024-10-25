# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    dut._log.info("Test project behavior")

    # Set the input values you want to test


    addends = [i for i in range(256)]

    for i in range(256):
        dut.a.value = addends[i]
        for j in range(256):
            dut.b.value = addends[j]

            # Wait for one clock cycle to see the output values
            await ClockCycles(dut.clk, 10)

            # The following assersion is just an example of how to check the output values.
            # Change it to match the actual expected output of your module:
            dut._log.info(f"value of output is: {dut.sum.value}.")
            # If these passes don't work, fail the program and show what you failed.
            assert dut.sum.value == ((addends[i] + addends[j]) & 0XFF)
    
            # Keep testing the module by changing the input values, waiting for
            # one or more clock cycles, and asserting the expected output values.
        
