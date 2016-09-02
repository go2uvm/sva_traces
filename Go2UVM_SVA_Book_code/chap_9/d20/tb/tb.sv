module top2;
  timeunit 1ns;
  timeprecision 1ns;
logic clk,reset_n,address,vaddress,retire;
d20 dut (.*);
default clocking @(negedge clk); endclocking
        
endmodule : top2

