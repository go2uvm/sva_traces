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
module d27(input clk,foo,bar,bar_steady); 
  timeunit 1ns;
  timeprecision 100ps;

sequence qRoseFoo_baduse; 
  @ (posedge clk) ##[0:$] $rose (foo);
endsequence : qRoseFoo_baduse

property ErrorUseOfDisable;      
// @ (posedge clk) disable iff (qRoseFoo_baduse.triggered)
   //  @ (posedge clk) disable iff (qRoseFoo_baduse.ended) 
 $rose(foo) |=> 
     ($past(bar) == bar)[*32]; 
endproperty : ErrorUseOfDisable
sequence qRoseFoo; 
  @ (posedge clk) ##[0:$] $rose (foo) && bar_steady;
endsequence : qRoseFoo

property GoodUseOfDisable; 
// @ (posedge clk) disable iff (qRoseFoo.triggered)
   // @ (posedge clk) disable iff (qRoseFoo.ended) 
   $rose(foo) && !bar_steady |=> 
     ($past(bar) == bar)[*32]; 
endproperty : GoodUseOfDisable

endmodule :d27
