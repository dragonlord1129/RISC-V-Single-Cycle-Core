module instruction_memory (
    input [31:0] Address,

    output [31:0] RD
);
    input rst,
    reg [31:0] memory [1023:0];

    assign RD = (rst == 1'b0) ? 32'h00000000 : memory[Address];
    
endmodule