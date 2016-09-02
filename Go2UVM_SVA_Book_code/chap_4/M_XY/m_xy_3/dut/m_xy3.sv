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
module m3 (input clk, k,x,y);
  timeunit 1ns;
  timeprecision 1ns;
  logic [7:0] x, y;
  always  @(posedge clk) begin : a1
    if(k) begin : if1 
      for (int i=0; i < 8; i++) begin : for1
       ap_OK: assert property (x[i] |=> y [i]) else
         $error("ap_ok failed for const i=%d", i);
      end : for1
    end : if1
  end : a1
endmodule : m3




