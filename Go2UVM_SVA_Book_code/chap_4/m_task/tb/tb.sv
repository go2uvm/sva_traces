module top2;
  timeunit 1ns;
  timeprecision 1ns;

bit[19:0] a=20'b10000000000000000001; 
   bit[16:0] b=17'b10000000000000001; 
  bit clk; 

 initial forever #10 clk=!clk; 
    default clocking cb_clk @ (posedge clk);  endclocking 
m_task dut(.*);
	        
endmodule : top2

