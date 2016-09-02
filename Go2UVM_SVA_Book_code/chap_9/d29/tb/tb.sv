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

logic bus_enb,bus_ack,done,dma_ack,mem_enb,bus_req,dma_req;
logic clk;
//Bus transfer sequence:  within 5 cycles bus_ack is followed by a bus transfer

d29 dut (.*);
default clocking cb @(posedge  clk);
endclocking

endmodule :top1
