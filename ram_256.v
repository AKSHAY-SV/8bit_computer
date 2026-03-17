`timescale 1ns / 1ps

module ram_256(input clk,we,oe,
               input [7:0]addr,data_in,
               output [7:0]bus_out);
               
reg [7:0]mem[255:0];

initial begin
    $readmemh("program.hex",mem);
end

always @(posedge clk) begin
    if(we)
        mem[addr] <= data_in;
end

assign bus_out = oe ? mem[addr] : 8'bz;

endmodule
