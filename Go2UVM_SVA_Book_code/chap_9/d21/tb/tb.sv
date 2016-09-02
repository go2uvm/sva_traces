module top2;
timeunit 1ns;
timeprecision 100ps;
logic clk,read_xctn,frame,trdy;
 

default clocking @(negedge clk); endclocking
        
endmodule : top2

