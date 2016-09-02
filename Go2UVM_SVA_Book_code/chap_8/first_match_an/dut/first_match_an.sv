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
module first_match_an(input clk,a=0,b=0,c=0,d=0,e=0); 
  

ap_fm_fm: assert property(@ (posedge clk)
  first_match($rose(a)  ##[1:$]b)  |=>  first_match(##[0:$] d) |-> e);

ap :  assert property(@ (posedge clk)
  first_match($rose(a)  ##[1:$]b)  |=>  ##[0:$] d |-> e);

 

endmodule : first_match_an

