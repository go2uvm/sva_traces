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
module q1_then_q2_after_5_clks1;
  
  timeunit 1ns;
  timeprecision 1ns;
logic clk, a,b,c,d;

 q1_then_q2_after_5_clks dut(.*);    
  default clocking @(negedge clk); endclocking
  initial  clk <= ~clk;

  initial begin : stim
    
    @(negedge clk);
    {a,b,c,d} <= 4'b1000;
    @(negedge clk);
    {a,b,c,d} <= 4'b0100;
    @(negedge clk);
    {a,b,c,d} <= 4'b0000;

    repeat (10) @(negedge clk);
    {a,b,c,d} <= 4'b0010;
     @(negedge clk);
    {a,b,c,d} <= 4'b0001;
    repeat (10) @(negedge clk);
    $finish;
    
  end : stim
  
endmodule : q1_then_q2_after_5_clks1
