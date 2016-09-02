module mpast (  input clk, a,input [2:0] index, input [7:0] var1, cur_var1, past_var1); 
    timeunit 1ns; 
    timeprecision 1ns; 
  `define DELAY 5 
   
      assign cur_var1 = var1; 


    a1: assert property ( 
        @(posedge clk) 
        a |-> $past(var1[index],`DELAY)  
        ) $display ("%0t %m PASS", $time); 
    else $display ("%0t %m FAIL", $time); 

    always @ (posedge clk) begin :aly
        automatic bit [2:0] aindex=1; 
        aindex= 3; 
        $display("aindex %d", aindex); 
        a1_auto: assert property ( // Fatal: (SIGSEGV) Bad handle or reference.
        @(posedge clk) 
            a |-> (var1[aindex])  //
            // a |-> $past(var1[index],`DELAY)  
            ) $display ("%0t %m PASS", $time); 
        else $display ("%0t %m FAIL", $time); 
    end 

    a_with_cur_var : assert property ( 
        @(posedge clk) 
        a |-> (cur_var1[index])  
        ) $display ("%0t %m PASS", $time); 
    else $display ("%0t %m FAIL", $time); 

    a_with_past_var : assert property ( 
        @(posedge clk) 
        a |-> (past_var1[index])  
        ) $display ("%0t %m PASS", $time); 
  else $display ("%0t %m FAIL", $time); 

endmodule : mpast 


