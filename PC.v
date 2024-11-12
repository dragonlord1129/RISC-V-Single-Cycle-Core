module PC (
    input [31:0] PC_next,
    
    output reg [31:0] PC
);
    input clk, rst,
    always @(posedge clk) begin
        if(~rst) begin
            PC <= PC_next;
        end else begin
            PC <= 32'h00000000;
        end
    end
    
endmodule