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
module m(input reset_n, clk, data_transfer, dma_req, go );
  timeunit 1ns;
  timeprecision 1ns;
  


    property p_accept_disable;
	       @ (posedge clk) disable iff (!reset_n)
         $rose(go )|->  
           dma_req |=> data_transfer[*1:256];    // transfer 256 words
  endproperty :  p_accept_disable
  ap_accept_disable : assert property (@ (posedge clk) p_accept_disable);

endmodule : m 
