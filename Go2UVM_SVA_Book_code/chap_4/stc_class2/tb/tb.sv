module top1;
   logic clk;
     
 tp1 dut(.*);
 
       default clocking d_clk  @(posedge clk);  endclocking 
    
    
endmodule : top1
//
