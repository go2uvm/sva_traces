module top1;
 
    logic clk;    logic [5:0]x,y;
   // initial forever #10 clk=!clk; 
 
top2 dut(.*);
 
       default clocking d_clk  @(posedge clk);  endclocking 
        
endmodule : top1
//
