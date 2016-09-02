	module top1(); // ERR: Range must be bounded by constant expressions
timeunit 1ns;
timeprecision 1ns;

  logic clk, enb, reset_n;
  logic [2:0] req, ack, done;
  logic [2:0]intrpt;
  // checker local variables and declarations
   //   begin : checker_equivalent 
       default clocking @(clk); endclocking
 //      default disable iff (!reset_n);
	 m_equivalent dut(.*);
	  
 endmodule : top1

