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
module top1(); 
  timeunit 1ns;
  timeprecision 100ps;
logic a = 1, b = 1;
logic [3:0] i = 1, j = 1;
logic clk;
reg req,ack,status_reg,done;


default clocking cb_clk @ (posedge clk);  endclocking 
 temp dut (.*);
endmodule : top1
