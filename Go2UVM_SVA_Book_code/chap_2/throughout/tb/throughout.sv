/*
    Code for use with the book
    "SystemVerilog Assertions Handbook, 3nd edition"ISBN  878-0-9705394-3-6

    Code is copyright of VhdlCohen Publishing & CVC Pvt Ltd., copyright 2012

    www.systemverilog.us  ben@systemverilog.us
    www.cvcblr.com, info@cvcblr.com

    All code provided in this book and in the accompanied website is distributed
    with *ABSOLUTELY NO SUPPORT* and *NO WARRANTY* from the authors.  Neither
    the authors nor any supporting vendors shall be liable for damage in connection
    with, or arising out of, the furnishing, performance or use of the models
    provided in the book and website.
*/
module throughout2;
  timeunit 1ns;
  timeprecision 1ns;
  logic clk=1'b1, a=1'b0, b, c=1'b1;
  
  throughout1 dut(.*);
  default clocking @(negedge clk); endclocking
  initial forever #5 clk = !clk; 
  initial begin 
   ##1; a <= 1'b1; b=1'b1;
   ##1; a <= 1'b1; b=1'b1;
   ##1; a <= 1'b1; b=1'b0;
   ##1; a <= 1'b0; b=1'b0;
   ##1; a <= 1'b0; b=1'b1; 
   ##1; a <= 1'b0; b=1'b0;
   repeat(10) ##1;

   $stop;   
  end


endmodule : throughout2

