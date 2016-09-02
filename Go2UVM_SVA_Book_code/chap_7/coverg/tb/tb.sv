module top1;
timeunit 1ns;
  timeprecision 1ns;
   logic  clk, smpl;
     logic [7:0] a;
  coverx dut (.*);
  default clocking @(posedge clk);
 endclocking
endmodule : top1
 
