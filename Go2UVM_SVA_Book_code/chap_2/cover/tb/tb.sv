module top1;
   logic a, b, clk ;
   // Instantiate the DUT
   
   cover_va dut (.*);
   
   default clocking cb_clk @ (posedge clk);
   endclocking
    
endmodule : top1
