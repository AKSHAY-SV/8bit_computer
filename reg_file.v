module register_file (input clk,rst,rega_load,rega_oe,regb_load,
                      input  [7:0] bus_in,
                      output [7:0] bus_out,
                      output [7:0] rega_out,regb_out);

reg [7:0] reg_a;
reg [7:0] reg_b;

always @(posedge clk) begin
    if (rst)            
        reg_a <= 8'b0;
    else if (rega_load) 
        reg_a <= bus_in;
end

always @(posedge clk) begin
    if (rst)            
        reg_b <= 8'b0;
    else if (regb_load) 
        reg_b <= bus_in;
end

assign bus_out  = rega_oe ? reg_a : 8'bz;

assign rega_out = reg_a;
assign regb_out = reg_b;

endmodule