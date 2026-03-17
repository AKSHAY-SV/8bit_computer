`timescale 1ns / 1ps

module fetch_unit(input clk,rst,pc_inc,pc_load,mar_load,raw_we,ram_oe, input[7:0]data_in, output[7:0]pc_out,mar_out,ram_data_out);
wire[7:0]bus;

assign bus = pc_out;

program_counter pc(.clk(clk),.rst(rst),.pc_inc(pc_inc),.pc_load(pc_load),.data_in(data_in),.pc_out(pc_out));
mar mar(.clk(clk),.rst(rst),.mar_load(mar_load),.data_in(bus),.mar_out(mar_out));
ram_256 ram(.clk(clk),.we(ram_we),.addr(mar_out),.data_in(data_in),.data_out(ram_data_out));
endmodule
