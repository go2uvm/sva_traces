module top1;
 logic clk0, clk_1, clk_2, clk_1b; 
   // Instantiate the DUT
   
   clk12 dut (.*);
   
   default clocking cb_clk @ (posedge clk0);
   endclocking
    
endmodule : top1
