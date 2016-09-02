module mpast1; 
   timeunit 1ns; 
   timeprecision 1ns; 
   logic [2:0] index; 
    logic [7:0] var1, cur_var1, past_var1; 

    logic clk, a; 
mpast dut(.*);
  `define DELAY 5 
   
    default clocking cb @ (posedge clk); 
    endclocking : cb 

    
    initial begin : sim 

    index = 0; 
    var1 = 1'b0; 

    ##5; 
    index = 7; 
    var1 [7] = 1'b1; 

    ##1; 
    a = 1; 
    ##1; 
    a = 0; 

    ##6; 
    a = 1; 
    ##1; 
    a = 0; 


    // ##10 $finish; 
end : sim 
endmodule : mpast1 

