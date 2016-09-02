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
   input clk);   // clock 
  timeunit 1ns;
  timeprecision 100ps;
  int mem_aarray[*]; // associative array to be used by property
  int mem_array_addr;  // local copy of mem_aarray[addr]
  wire mem_aarray_exists;  // exists at specified address//CVC added "r"
  // note: LRM 17.4.1 Operand types does not allow use 
  // of methods on associative array in properties. 
  assign mem_aarray_exists = mem_aarray.exists(addr); 
// //   always@ (posedge clk)
// //     if (reset_n==1'b0) mem_aarray.delete; // Clears AA elements
// //     else if (write) mem_aarray[addr] <= wdata; // store data
 
 always@ (posedge clk)
    if (reset_n==1'b0) mem_aarray.delete; // Clears AA elements
    else if (write) #1 mem_aarray[addr] = wdata; // store data
 
 assign mem_array_addr = mem_aarray[addr]; // errata 3/23/05 
 
  property p_read_after_write;
    @(posedge clk)
    (read && mem_aarray_exists) |-> mem_array_addr==rdata; 
   endproperty : p_read_after_write
   ap_read_after_write : assert property (p_read_after_write);
 
   property p_read_before_write;
     @(posedge clk)
      not (read && !mem_aarray_exists);
   endproperty : p_read_before_write
   ap_read_before_write : assert property (p_read_before_write);
endmodule : memory_data_integrity_check
