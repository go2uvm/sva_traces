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
module top1;
  logic clk, bus_err, abort_command, retransmit_cmd;
  typedef  enum {SECURITY, FAST} mode_e;
  mode_e mode;
 sect1_1_3_1 dut(.*);
  default clocking cb @(posedge clk);
  endclocking 
 

endmodule : top1
