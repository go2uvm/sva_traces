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
module fusiont(input start,clk,a,b,c);
  timeunit 1ns;
  timeprecision 1ns;

    ap_fusion_co : assert property(@ (posedge clk) start |=> b[*0] ##0  c );
  ap_fusion_an : assert property(@ (posedge clk) b[*0] ##0  c |=> start);
  
endmodule : fusiont 

