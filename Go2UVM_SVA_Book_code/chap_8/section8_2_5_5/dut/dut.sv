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
 
 
module my_module (input  [31:0] a,              
                 input       clk,k,
                 input  [31:0] b);

  timeunit 1ns;                             
  timeprecision 100ps;                

  logic k;  // local variable used inside this module

  property pTest; @ (posedge clk) k |=>a==b; endproperty : pTest

  apTest  : assert property (pTest) else 
                 $display ("%0t %m a=, b= %0h ", $time, a, b);

  initial $timeformat(-9, 2, " ns",12);  // ns, 2 digit precision, ns display, 12 bits total
 
  //...  // additional code with the model functionality
endmodule : my_module

