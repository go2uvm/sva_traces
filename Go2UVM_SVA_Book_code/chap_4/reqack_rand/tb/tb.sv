module top2;
  timeunit 1ns;
  timeprecision 1ns;
logic clk;
logic a, b;
logic [31:0] count;
   logic y;


 default clocking @(negedge clk); endclocking

	
 initial forever #5 clk=!clk;

chk_count dut(.*);
	        
endmodule : top2

