module top2;
timeunit 1ns;
  timeprecision 100ps;
reg clk,read,busy;

default clocking @(negedge clk); endclocking
d22 dut(.*);        
endmodule : top2

