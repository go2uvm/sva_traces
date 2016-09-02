module top1;
   logic clk, ack1, ack2, req1, req2, bus_switch; 
   logic[1:0] bus_select; 
    
   // Instantiate the DUT
   
   top2 dut (.*);
   
   default clocking cb_clk @ (posedge clk);
   endclocking
    
endmodule : top1
