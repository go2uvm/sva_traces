module top1;
   logic clk, a, b, acknowledge, done;
   // Instantiate the DUT
   
   cover_m dut (.*);
   
 default clocking cb_clk @ (posedge clk);
   endclocking
 
      
endmodule : top1
