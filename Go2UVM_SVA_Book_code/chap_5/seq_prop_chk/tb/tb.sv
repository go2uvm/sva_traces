module top1;
timeunit 1ns;
   timeprecision 1ns;

  logic clk, req,ack;
m dut(.*);
  default clocking @(negedge clk); endclocking

    
endmodule : top1
//
