module top1;
   logic clk, clk0, clk1, clk2, a, b, c, d, e; 
    
 lce dut(.*);
 
   initial forever #10 clk=!clk; 

    default clocking cb_clk @ (posedge clk);
    endclocking 
    
endmodule : top1
//
