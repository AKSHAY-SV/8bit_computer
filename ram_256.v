`timescale 1ns / 1ps

module ram_256(input clk,we, input [7:0]addr,data_in,data_out);
reg [7:0] mem [255:0];

initial begin
    $readmemh("program.hex",mem);
end

assign data_out = mem[addr];

always @(posedge clk) begin
    if(we)
        mem[addr] <= data_in;
end
endmodule
