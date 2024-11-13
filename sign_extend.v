module sign_extend (
    input [31:0] in,
    output [31:0] imm_extend
);

    wire sign_bit = in[31];  // Extract the sign bit (assuming the 12-bit immediate is in bits 31:20)
    assign imm_extend = { {20{sign_bit}}, in[31:20] };

endmodule
