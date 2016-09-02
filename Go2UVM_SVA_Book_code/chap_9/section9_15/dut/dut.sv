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
module memory_data_integrity_check (
   input write, // memory write
   input read,  // memory read
   input int wdata, // data written to memory
   input int rdata, // data read from memory
   input int addr,  // memory address 
   input reset_n, // active low reset
   input clk,p_read_before_write,p_read_after_write);   // clock 
  timeunit 1ns;
  timeprecision 100ps;
  int mem_aarray[*]; // associative array to be used by property
  wire mem_aaray_exists;  // exists at specified address
  // note: LRM 17.4.1 Operand types does not allow use 
  // of methods on associative array in properties. 
  assign mem_aarray_exists = mem_aarray.exists(addr); 
 
  always@ (posedge clk)
    if (reset_n==1'b0) mem_aarray.delete; // Clears AA elements
    else if (write) mem_aarray[addr] = wdata; // store data
 
 assign mem_aarray_addr = mem_aarray[addr];

property p_read_after_write1;
    @(posedge clk)
    (read && mem_aarray_exists) |-> mem_aarray_addr==rdata; 
   endproperty : p_read_after_write1
   ap_read_after_write : assert property (@(posedge clk)p_read_after_write);

   property p_read_before_write1;
     @(posedge clk)
      not (read && !mem_aarray_exists);
   endproperty : p_read_before_write1
   ap_read_before_write : assert property (@(posedge clk)p_read_before_write);

endmodule : memory_data_integrity_check
