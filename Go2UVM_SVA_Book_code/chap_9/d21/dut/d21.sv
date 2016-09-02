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
module d21(input clk,read_xctn,frame,trdy); 
  
//reg clk,read_xctn,frame,trdy;
`define false 1'b0

property pReadTrdyFrame; 
   @ (posedge clk) not  ($rose(read_xctn) ##1 !frame[*0:10] ##1 frame ##1 trdy); endproperty : pReadTrdyFrame

property pReadTrdyFrame2; 
  @ (posedge clk) $rose(read_xctn) ##1 !frame[*0:10] ##1 frame ##1 trdy |-> `false; endproperty : pReadTrdyFrame2
property pReadTrdyFrame3; 
  @ (posedge clk) $rose(read_xctn) ##1 !frame[*0:10] ##1 frame |=> trdy ##0 `false; 
endproperty : pReadTrdyFrame3
endmodule : d21
