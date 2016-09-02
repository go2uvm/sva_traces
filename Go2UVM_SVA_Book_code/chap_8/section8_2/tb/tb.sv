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
module test1;
 timeunit 1ns;
  timeprecision 1ns;
logic clk ;
  logic load ;
  logic [3:0] count = 4'h0;
  logic [3:0] prevcount;


bit_width dut (.*);
    initial forever #20 clk = ~clk; 
 
   default clocking @(negedge clk); endclocking
  
  
endmodule : test1

