module top1;
 logic[8:0] data; // static variable
    logic clk; 
    initial forever #10 clk=!clk; 

 
 static_auto dut(.*);
 
       default clocking d_clk  @(posedge clk);  endclocking 
         
endmodule : top1
//
