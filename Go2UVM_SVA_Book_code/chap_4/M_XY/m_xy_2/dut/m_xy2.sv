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
 

module m2 (input x,y,clk);
  timeunit 1ns;
  timeprecision 1ns;
  logic [7:0] x, y;
  //bit clk; 
 // initial forever #10 clk=!clk; 
  always  @(posedge clk) begin
   int i;   // non-constant variable 
   for (i=0; i < 8; i++) begin
     $display("i=%d, $sampled(i)= %d", i, $sampled(i)); 
     ap_unexpected1: assert property (x[i] |=> y [i]);
     ap_unexpected2: assert property (x[(i)] |=> y [i]);
     ap_OK       : assert property (x[(i)] |=> y [(i)]);
   end
  end
endmodule : m2


