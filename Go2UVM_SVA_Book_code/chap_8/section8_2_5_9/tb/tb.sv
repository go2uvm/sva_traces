module top2;
timeunit 1ns;
timeprecision 1ns;
logic reset_n, clk, push1, pop1, fifofull, fifocount_err;
 
 default clocking cb @ (posedge clk);  endclocking  
	
 
m dut(.*);
	        
endmodule : top2

