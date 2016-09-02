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
module memory_data_integrity_check (
     input logic write, // memory write
     input logic read,  // memory read
     input logic[31:0] wdata, // data written to memory
     input logic[31:0]  addr,  // memory address -- small for simulation 
     input logic reset_n, // active low reset
     input logic clk);   // clock 
  timeunit 1ns;   timeprecision 100ps;
  int mem_aarray[*]; // associative array (AA) to be used by property
  logic [31:0] rdata;  // data read from memory
  logic  mem_aarray_exists;  // exists at specified address
  logic [31:0] rdata_g=0;
  assign mem_aarray_exists  = mem_aarray.exists(addr); 
  assign rdata 		    = mem_aarray[addr];  // L16
  always@ (posedge clk)
    if (reset_n==1'b0) mem_aarray.delete; // Clears AA elements
    else if (write) mem_aarray[addr]  = wdata; // store data

  property p_read_after_write;
    $rose(read && mem_aarray_exists) |-> rdata != 32'bx;
            // mem_aarray[addr]==rdata;  // illegal use of mem_aarray[addr]
   endproperty : p_read_after_write
   ap_read_after_write : assert property (@(posedge clk) p_read_after_write);

   property p_read_before_write;
      not (read && !mem_aarray_exists);
   endproperty : p_read_before_write
   ap_read_before_write : assert property (@(posedge clk) p_read_before_write);
endmodule : memory_data_integrity_check


module top(input
    write, // memory write
   read,  // memory read
 input int wdata, // data written to memory
  input int rdata, // data read from memory
  input[31:0] addr,  // memory address 
  input reset_n=1'b1, // active low reset
  input clk=1'b1);  // clock
  memory_data_integrity_check mem_check1 (.*);

  
endmodule : top 
  

