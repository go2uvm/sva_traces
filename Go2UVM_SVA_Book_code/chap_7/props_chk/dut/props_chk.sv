parameter WIDTH = 16; 
parameter MODEL_ID=1; // ID==1 then model with architecture RTL1
// else ID==2 then model with architecture RTL2
// Note: parameters are illegal in a checker, but can be declared outside the scope of the checker 
//           Checkers cn lso use input arguments instead of parameters.  
module  props_chk (input  load, reset_n, clk,output 
  // verification module
    [WIDTH-1:0] q, d,  d_r); 
     
    //timeunit 1ns;  timeprecision 100ps;               
    // Example of poor use of property definition that can create a vacuous assertion 
    // property pD_r1; // for architecture RTL1
    //    @ (posedge clk) disable iff (!reset_n)
    //      MODEL_ID==1 |=> d_r== $past(d);
    //  endproperty : pD_r1
    //  apD_r1 :  assert property (pD_r1);
   // default clocking cb_clk @ (posedge clk);  endclocking 
    generate  
        begin : gen_conditional_assert
            if (MODEL_ID==1) begin : mode1
                apD_r1 :  assert property (@ (posedge clk) 
                    disable iff (!reset_n)
                    d_r== $past(d));
            end : mode1 // if (MODEL_ID==1)

            else begin : mode2
                apD_r2 :  assert property (@ (posedge clk) 
                    disable iff (!reset_n)
                    load |=> d_r== $past(d));
            end : mode2 // else 
        end : gen_conditional_assert
    endgenerate
endmodule  : props_chk

