module top2;
  timeunit 1ns;
  timeprecision 1ns;
bit clk, a, b, c;
    byte byt, byts; 

  
initial forever #10 clk=!clk; 
    default clocking cb_clk @ (posedge clk);  endclocking 
 
autovrab dut (.*);
  
        
endmodule : top2

