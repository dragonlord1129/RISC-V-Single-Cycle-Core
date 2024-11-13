`include "PC.v"
`include "instruction_memory.v"
`include "registerFile.v"
`include "sign_extend.v"
`include "alu.v"
`include "control_unit.v"
`include "data_memory.v"
`include "pc_adder.v"
module single_cycle (clk, rst);
    input clk, rst;
    wire [31:0] PC_TOP, PC_4,  RD_Instruction, readData1_TOP, readData2_TOP, imm_extend_TOP, result_TOP, RD;
    wire [2:0] ALUControl_TOP;
    wire [1:0] ImmSrc;
    wire RegWrite, ALUSrc, MemWrite, ResultSrc, Branch; 
    wire carry, zero, negative, overflow;

    PC PC(
        .clk(clk),
        .rst(rst),
        .PC_next(PC_4),
        .PC(PC_TOP)
    );
    pc_adder pc_adder(
        .a(PC_TOP),
        .b(32'd4),
        .c(PC_4)
    );

    instruction_memory instruction_memory(
        .rst(rst),
        .Address(PC_TOP),
        .RD(RD_Instruction)
    );

    sign_extend sign_extend(
        .in(RD_Instruction), 
        .imm_extend(imm_extend_TOP)
    );

    registerFile registerFile(
        .clk(clk),
        .rst(rst),
        .rs1(RD_Instruction[19:15]),
        .rs2(RD_Instruction[24:20]),
        .rd(RD_Instruction[11:7]),
        .writeEnable(RegWrite),
        .writeData(RD),
        .readData1(readData1_TOP),
        .readData2(readData2_TOP)
    );
    alu alu(
        .A(readData1_TOP),
        .B(imm_extend_TOP),
        .ALUControl(ALUControl_TOP),
        .result(result_TOP),
        .carry(carry), 
        .zero(zero), 
        .overflow(overflow), 
        .negative(negative)
    );
    control_unit control_unit(
        .opcode(RD_Instruction[6:0]),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .Branch(Branch),
        .funct3(RD_Instruction[14:12]),
        .funct7(RD_Instruction[31:25]),
        .ALUControl(ALUControl_TOP)
    );
    data_memory data_memory(
        .A(result_TOP), 
        .writeData(), 
        .clk(clk), 
        .rst(rst), 
        .writeEnable(), 
        .RD(RD)
    );

endmodule