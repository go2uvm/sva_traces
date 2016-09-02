module top1;
logic clk, a, b, c, d, e, f,g, h, enb;
    initial forever #10 clk=!clk; 
   
 
 syncs dut(.*);
 
       default clocking cb_clk @ (posedge clk);  endclocking    
      
endmodule : top1
//
