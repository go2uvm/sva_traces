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
module seq_trigger21; 
  timeunit 1ns;
  timeprecision 1ns;

  logic clk , load_mem, done, ready, ready2;

 seq_trigger2 dut (.*);

 default clocking @(negedge clk); endclocking
  initial forever #5 clk = !clk; 
  initial begin 
    repeat (100)##1;
    $display("end of simulation");
    $stop; 
   end

  always ##1 assert (std::randomize(load_mem, done));

 
endmodule : seq_trigger21

				 		   







