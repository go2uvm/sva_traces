module top1;

timeunit 1ns;
  timeprecision 1ns;
  logic load, reset_n,clk;
  logic [WIDTH-1:0] q, d,d_r;
  
      
   props_chk  dut (.*);
  default clocking @(posedge clk);
 endclocking
endmodule : top1
 
