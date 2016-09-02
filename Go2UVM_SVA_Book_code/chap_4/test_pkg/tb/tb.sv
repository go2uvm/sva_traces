module top2;
  timeunit 1ns;
  timeprecision 1ns;
logic clk;
 default clocking cb_clk @ (clk);  endclocking 

k dut (.*);
  
        
endmodule : top2

