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
module d23(input clk,x);
  timeunit 1ns;
  timeprecision 100ps;
`define false 1'b0
property pMustBeOnehot;  // x must be one-hot 
  @ (posedge clk)  $onehot(x); // 
endproperty : pMustBeOnehot
property pMustBeStableFor3Cycles;
     @ (posedge clk)    ! $stable(x) |=> $stable(x) [*2];
endproperty : pMustBeStableFor3Cycles

property pNewXin3Ccyles;
       @ (posedge clk)  !$stable(x) ##[1:2] !$stable(x) |-> `false;
endproperty : pNewXin3Ccyles

endmodule : d23
