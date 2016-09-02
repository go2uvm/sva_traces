module top1;
timeunit 1ns;
  timeprecision 1ns;
  logic   clk10, clk13, a, b, c; 
   t dut (.*);

initial forever #10 clk10=!clk10;
    initial forever #13 clk13=!clk13; 
   
    default clocking cb_clk13 @ (posedge clk13);  endclocking 
   
endmodule : top1
 
