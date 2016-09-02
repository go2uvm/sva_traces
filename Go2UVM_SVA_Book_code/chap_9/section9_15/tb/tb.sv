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
module memory_data_integrity_check1 ;
 timeunit 1ns;
  timeprecision 100ps;


memory_data_integrity_check dut(.*);
    logic write,read,reset_n, clk,p_read_before_write,p_read_after_write;
     int wdata, rdata,addr; // data read from memory
   
 default clocking cb @(posedge clk);
endclocking 



endmodule : memory_data_integrity_check1
