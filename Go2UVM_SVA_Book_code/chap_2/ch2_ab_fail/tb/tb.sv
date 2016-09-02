module top1;
   logic a, b, c, d, e, f, clk;

   // Instantiate the DUT
   
   ch2_ab_fail dut (.*);
   
   default clocking cb_clk @ (posedge clk);
   endclocking
    
endmodule : top1
