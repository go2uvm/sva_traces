/*
Code for use with the book
"SystemVerilog Assertions Handbook, 2nd edition"ISBN  878-0-9705394-8-7

Code is copyright of VhdlCohen Publishing & CVC Pvt Ltd., copyright 2009 

www.systemverilog.us  ben@systemverilog.us
www.cvcblr.com, info@cvcblr.com

All code provided in this book and in the accompanied website is distributed
 with *ABSOLUTELY NO SUPPORT* and *NO WARRANTY* from the authors.  Neither
the authors nor any supporting vendors shall be liable for damage in connection
with, or arising out of, the furnishing, performance or use of the models
provided in the book and website.
*/
parameter WIDTH = 16;  
module e_props (   // verification module
    input logic[WIDTH-1:0] q,
    input logic[WIDTH-1:0] d,      
    input logic load,
    input logic reset_n, 
    input logic clk, 
    input logic[WIDTH-1:0] d_r );
  timeunit 1ns;                             
  timeprecision 100ps;  
  parameter MODEL_ID=1; // ID==1 then model with architecture RTL1
                     // else ID==2 then model with architecture RTL2
    // Example of poor use of property definition to create a vacuous assertion 
     // when MODEL_ID == 2
 // property pD_r1; // for architecture RTL1
 //    @ (posedge clk) disable iff (!reset_n)
 //      MODEL_ID==1 |=> d_r== $past(d);
 //  endproperty : pD_r1
 //  apD_r1 :  assert property (pD_r1);
 generate  begin : gen_conditional_assert
    if (MODEL_ID==1) begin 
      property pD_r1;  
        @ (posedge clk) disable iff (!reset_n)
          d_r== $past(d);
      endproperty : pD_r1
      apD_r1 :  assert property (pD_r1);
    end // if (MODEL_ID==1)
    else begin
      property pD_r2;  
        @ (posedge clk) disable iff (!reset_n)
         load |=> d_r== $past(d);
      endproperty : pD_r2
      apD_r2 :  assert property (pD_r2);
    end // else 
  end : gen_conditional_assert
  endgenerate
endmodule : e_props
