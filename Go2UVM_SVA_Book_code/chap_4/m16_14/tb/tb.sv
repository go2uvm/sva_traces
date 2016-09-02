module top1;
 logic clk; 
    logic[11:0] foo, bar;  
    initial forever #10 clk=!clk; 
 m16_14 dut(.*);
 
       default clocking d_clk  @(posedge clk);  endclocking 
    
    
endmodule : top1
//
