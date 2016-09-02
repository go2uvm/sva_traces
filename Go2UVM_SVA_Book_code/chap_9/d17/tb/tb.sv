module top2;
  timeunit 1ns;
  timeprecision 1ns;
logic clk,read,write,rd_served,interrupt,wr_served; 
d17 dut (.*);
default clocking @(negedge clk); endclocking
        
endmodule : top2

