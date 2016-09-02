module top1;
    logic clk, a, b, d,f, k,z ,c, e, m, q; 
   
   // Instantiate the DUT
   
   always_usage dut (.*);
   
   default clocking cb_clk @ (posedge clk);
   endclocking
    
endmodule : top1
