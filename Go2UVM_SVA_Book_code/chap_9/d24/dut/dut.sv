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
module d24(input clk,reset_n,t=1);// Once reset_n is high (disabled), it remains disabled 
// Checked at every clock cycle.
  timeunit 1ns;
  timeprecision 100ps;

property pno_reset_forever;
 @(posedge clk) !reset_n |=> !reset_n;
endproperty : pno_reset_forever
apno_reset_forever_1: assert property (pno_reset_forever);
// t is reset after the first clock 

// This property is fired once.  Thereafter, the property is 
// TRUE vacuously because t==0 thereafter. 
property pReset5Cycles;
 @(posedge clk) t |-> !reset_n[*5] ##1 reset_n;
endproperty : pReset5Cycles
mpReset5Cycles_1: assert property (pReset5Cycles);
property preset_at_init;  
!reset_n[*5] ##1 reset_n;
endproperty : preset_at_init

initial begin
 @(posedge clk)  mpreset_at_init_1 : assert property (preset_at_init);
end

endmodule : d24
  
