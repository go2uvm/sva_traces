module top2;
  timeunit 1ns;
  timeprecision 1ns;
bit clk;
default clocking @(negedge clk); endclocking

 top dut (.*);
  
        
endmodule : top2

