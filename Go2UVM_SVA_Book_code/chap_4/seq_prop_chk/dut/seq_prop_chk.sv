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
module m(input clk,req,ack); 

   sequence q_ab2 (x, y); x ##1 y; endsequence : q_ab2
  property p_ab (a, b); a ##1 b; endproperty : p_ab

  module a_chk(input seq, prop, input clk);
    ap_prop: assert property( @ (clk) prop);
    cs_seq: cover sequence(@ (clk) seq);
  endmodule : a_chk
 endmodule : m

