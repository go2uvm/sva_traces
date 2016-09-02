module top1;
   logic clk, k;
  logic [7:0] x, y;
    
 m3 dut(.*);
 
       default clocking d_clk  @(posedge clk);  endclocking 
    
    
endmodule : top1
//
