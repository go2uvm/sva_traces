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
module d22(input clk,read,busy); 
  //timeunit 1ns;
  //timeprecision 100ps;
//reg clk,read,busy;
sequence qFallRead; 
   @ (posedge clk) ##[0:$] $fell(read); 
endsequence : qFallRead
sequence qRiseRead; 
 @ (posedge clk) ##[0:$] $rose(read); 
endsequence : qRiseRead
property pReadBusyRise;
 @ (posedge clk) disable iff (qFallRead.triggered )
   //  @ (posedge clk) disable iff (qFallRead.ended )  
   (read) |-> (busy[*3]) ;
endproperty : pReadBusyRise
property pReadBusyFell;
 @ (posedge clk) disable iff (qRiseRead.triggered )
   // @ (posedge clk) disable iff (qRiseRead.ended ) 
   ($fell(read && busy)  |-> (busy[*2] ##1 !busy));
endproperty : pReadBusyFell
endmodule : d22
