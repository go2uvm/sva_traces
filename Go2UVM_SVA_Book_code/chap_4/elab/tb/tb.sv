module top1;
   
    parameter WIDTH=4; 
    logic[WIDTH-1:0] vect, w; 
    logic clk,trig; 
   
     
 elab dut(.*);
 
        default clocking cb_clk @ (posedge clk);  endclocking 
    
endmodule : top1
//
