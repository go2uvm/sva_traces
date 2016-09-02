module clk12(
    input  clk0, clk_1=1'b1, clk_2=1, clk_1b); 

    assign #1 clk_0b =  clk0;
    
    sequence seq_1; 
        $rose (clk_1) ##0 $rose(clk_2); 
        // @ (posedge clk_1) $rose (clk_1)is always 0 
    endsequence 


    sequence seq_2; 
        $rose (clk_1) ##0 $fell(clk_2); 
        // @ (posedge clk_1)  $rose (clk_1_ is always 0
    endsequence 


    property my_prop; 
        @ (posedge clk_0b) 
            seq_1 |-> seq_2; 
    endproperty 


    my_asset : assert property (my_prop)  else  $error; 

endmodule : clk12
