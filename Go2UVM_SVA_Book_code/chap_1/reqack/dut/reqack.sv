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
module reqack(input request,done,clk ,input acknowledge,data_enable) ;
  timeunit 1ns;
  timeprecision 1ns;

 // logic clk =1'b1, request=0, acknowledge, data_enable, done;

  property p_handshake;  
     request |=> acknowledge ##1 data_enable ##1 done; 
  endproperty : p_handshake
  ap_handshake : assert property (@ (posedge clk) p_handshake);

 

	
endmodule : reqack

