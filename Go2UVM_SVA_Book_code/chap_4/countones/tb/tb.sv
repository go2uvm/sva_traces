module top2;
  timeunit 1ns;
  timeprecision 1ns;
 logic [31:0] control_reg;
 logic [1:0] bad_bits;
 logic clk, init_done; 
    default clocking cb_clk @ (posedge clk); endclocking 
     

countones dut (.*);
  
    initial begin
        wait(init_done); 
        bad_bits[0] = 'x;
        bad_bits[1] = 'z; 
    end
 
     
endmodule : top2

