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
module an_an_co(input clk,a,b,c); 
  timeunit 1ns;
  timeprecision 1ns;

  

  ap_an_an_co: assert property(@ (posedge clk) 
         a[*0:2] |-> b); 

  am_an_an_co: assume property(@ (posedge clk) 
         a[*1:2] |-> ##[1:3] b |=> c[*1:2]);

  ap_an_an_coFM: assert property(@ (posedge clk) 
         first_match(a[*1:2]) |-> 
               first_match(##[1:3] b) |=> c[*1:2]);   

  
endmodule : an_an_co
				 
