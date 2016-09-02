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

typedef  enum {SECURITY, FAST} mode_e;
module sect1_1_3_1(input  clk, bus_err, abort_command, retransmit_cmd,input  mode_e mode );
 // logic clk, bus_err, abort_command, retransmit_cmd;
  
 // mode_e mode;
  
  property p_retransmit1; 
     (mode==SECURITY && bus_err) |=> abort_command ##1 retransmit_cmd; 
  endproperty : p_retransmit1
  ap_retransmit1 : assert property(@(posedge clk) p_retransmit1);

  property p_no_retransmit; 
     (mode==FAST && bus_err) |=> not( abort_command ##1 retransmit_cmd); 
  endproperty : p_no_retransmit
  ap_no_retransmit : assert property(@ (posedge clk) p_no_retransmit);


endmodule : sect1_1_3_1
