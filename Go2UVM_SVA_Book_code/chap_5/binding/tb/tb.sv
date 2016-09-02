module top2;
  timeunit 1ns;
  timeprecision 1ns;
logic clk;
logic x, y, a, b;
 default clocking @(negedge clk); endclocking

	
 initial forever #5 clk=!clk;

top dut(.*);
	        
endmodule : top2

