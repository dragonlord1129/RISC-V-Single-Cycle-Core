module registerFile (
    input [4:0] rs1, rs2, rd,
    input writeEnable,
    input [31:0] writeData,
    
    output [31:0] readData1, readData2,
);
    input clk, rst;
    reg [31:0] x [31:0];

    //read function
    assign readData1 = (~rst) ? x[rs1] : 32'h00000000;
    assign readData2 = (~rst) ? x[rs2] : 32'h00000000;

    //write function
    always @(posedge clk ) begin
        if(~rst) begin
            if(writeEnable) begin
                x[rd] <= writeData;
            end
        end
    end
    
endmodule