// `timescale 1ns/1ps
`include "single_cycle.v"

module tb_single_cycle();
    reg clk, rst;

    // Instantiate the single_cycle module
    single_cycle uut (
        .clk(clk),
        .rst(rst)
    );

    // Clock Generation: 10ns period (100MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Apply reset
        rst = 1;
        #10;  // Wait for 10ns with reset active
        
        // Release reset
        rst = 0;
        
        // Run simulation for a certain number of cycles to observe behavior
        #1000;

        // End simulation
        $stop;
    end

    // Monitor signals to display values for debugging
    initial begin
        $monitor("Time = %0d ns | PC = %h | Instruction = %h | ALU Result = %h | RD (Mem/ALU) = %h | Zero Flag = %b",
                 $time, uut.PC_TOP, uut.RD_Instruction, uut.result_TOP, uut.RD, uut.zero);
    end

    // GTKWave dump
    initial begin
        $dumpfile("single_cycle_tb.vcd");  // Name of the VCD file for GTKWave
        $dumpvars(0, tb_single_cycle);     // Dump all variables in tb_single_cycle and its hierarchy
        
        // Specific variables for easy viewing in GTKWave
        $dumpvars(1, uut.PC_TOP);
        $dumpvars(1, uut.PC_4);
        $dumpvars(1, uut.RD_Instruction);
        $dumpvars(1, uut.readData1_TOP);
        $dumpvars(1, uut.readData2_TOP);
        $dumpvars(1, uut.imm_extend_TOP);
        $dumpvars(1, uut.result_TOP);
        $dumpvars(1, uut.RD);
        $dumpvars(1, uut.ALUControl_TOP);
        $dumpvars(1, uut.RegWrite);
        $dumpvars(1, uut.ALUSrc);
        $dumpvars(1, uut.MemWrite);
        $dumpvars(1, uut.ResultSrc);
        $dumpvars(1, uut.Branch);
        $dumpvars(1, uut.zero);
        $dumpvars(1, uut.carry);
        $dumpvars(1, uut.negative);
        $dumpvars(1, uut.overflow);
    end

endmodule
