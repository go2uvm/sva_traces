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
// This module monitors the memory transactions and verifies 
 // data integrity of the external memory 
module top1 (
   input write, // memory write
   input read,  // memory read
   input int wdata, // data written to memory
   input int rdata, // data read from memory
   input int addr,  // memory address 
   input reset_n, // active low reset
   input clk);   // clock 
  timeunit 1ns;
  timeprecision 100ps;
  int mem_aarray[*]; // associative array to be used by property
  wire mem_aaray_exists;  // exists at specified address
  // note: LRM 17.4.1 Operand types does not allow use 
  // of methods on associative array in properties. 

memory_data_integrity_check dut(.*);
default clocking cb @(posedge clk);
endclocking 
 endmodule : top1
