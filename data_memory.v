module data_memory (Address, writeData, clk, writeEnable, RD);
    input clk, writeEnable;
    input [31:0] Address, writeData;

    output [31:0] RD;

    reg [31:0] data_memory [1023:0];

    //read
    assign RD = (~writeEnable) ? data_memory[Address] : 32'h00000000;

    //write
    always @(posedge clk ) begin
        if(writeEnable) begin
            data_memory[Address] <= writeData;
        end
    end
endmodule