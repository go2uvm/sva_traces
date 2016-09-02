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
timeunit 1ns;
timeprecision 100ps;
  logic clk=1, bus_ack=0, bus_enb=0, done=0, 
               dma_ack=0, mem_enb=0, bus_req=0, dma_req=0;
 default clocking cb @(posedge clk);
endclocking 
 initial forever #50 clk = !clk; 
 always @ (posedge clk) 
   assert(std::randomize (bus_ack, bus_enb, done, dma_ack, 
                             mem_enb, bus_req, dma_req));//CVC change addedstd
endmodule : top1  

