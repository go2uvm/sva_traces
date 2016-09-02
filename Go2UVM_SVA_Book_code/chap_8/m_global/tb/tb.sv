module top2;
  timeunit 1ns;
  timeprecision 1ns;
  bit clk, clk13, a, b, c; 
 clocking clk_global @(posedge clk); endclocking
 default clocking cb_clk13 @ (posedge clk13);  endclocking  
	
 
m_global dut(.*);
	        
endmodule : top2

