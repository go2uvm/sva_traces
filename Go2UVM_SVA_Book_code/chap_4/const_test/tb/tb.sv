module top2;
  timeunit 1ns;
  timeprecision 1ns;
    logic clk;
    logic[3:0] a; 
initial forever #10 clk=!clk;
 const_test dut (.*); 
     

endmodule : top2

