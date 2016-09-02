

module top2;
timeunit 1ns;
timeprecision 1ns;
logic clock=1;
 logic [31:0]     data;
  logic [31:0]    result;

initial forever #50 clock=!clock; 
 default clocking cb @ (posedge clock);  endclocking  
	
 
top dut(.*);
	        
endmodule : top2

