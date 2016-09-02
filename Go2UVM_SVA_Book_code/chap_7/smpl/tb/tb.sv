module top1;
timeunit 1ns;
  timeprecision 1ns;
  logic clk,a,b,c; 
   smpl dut (.*);
  default clocking @(posedge clk);
 endclocking
endmodule : top1
 
