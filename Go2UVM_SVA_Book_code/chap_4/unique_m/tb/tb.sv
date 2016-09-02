module top1;
logic[3:0] a; 
   logic clk, b; 
    initial forever #10 clk=!clk; 
 unique_m dut(.*);
 
       default clocking @(negedge clk); endclocking
      
endmodule : top1
//
