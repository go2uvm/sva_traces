module top2;
  timeunit 1ns;
  timeprecision 1ns;

logic clk, a, b, c, d; 

 default clocking @(negedge clk); endclocking
 
m dut (.*);
  
        
endmodule : top2

