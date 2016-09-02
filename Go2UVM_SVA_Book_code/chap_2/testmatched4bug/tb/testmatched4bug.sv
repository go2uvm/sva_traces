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
module testmatched1;
  timeunit 1ns;
  timeprecision 1ns;
  logic clk  =1, sysclk=1, a_sysclk=1, a_clk=1, b_sysclk=1, c=1, d_clk=1;
  // IEEE 1800 2005, 17.7.10 Detecting and using endpoint of a sequence
  // IEEE 1800 2010, 16.14.5 Detecting and using end point of a sequence in multiclock context
  // Method triggered can also be applied to detect the end point of a sequence from within 
  // a multiclocked sequence. In both cases, the ending clock of the sequence instance 
  // to which triggered is applied shall be the same as the clock in
  // the context where the application of method triggered appears
  // [comment] triggered applied (@ sysclk)  triggered appears(@ clk)
  // Unlike triggered, matched provides synchronization between two clocks by storing 
  // the result of the source sequence until the arrival of the first clock tick 
  // of the destination sequence after the match.
  // [comment] The clock in the context where the application of method triggered appears
  // is the clock of the destination sequence after the match.  
  // ?? Or is it before the match? 
    
  testmatched dut(.*);
default clocking @(negedge clk); endclocking

  initial forever #5 clk=!clk;
  initial forever #8 sysclk=!sysclk;

   initial begin
     repeat(10) ##1;	
     c <= 1'b1;
     ##1; c <= 1'b1;
     repeat(2) ##1;
     d_clk <= 1'b1;
     ##1;
     d_clk <= 1'b0;
     ##1;
   end
  initial begin
     repeat(2) @ (posedge sysclk);	
     a_sysclk <= 1'b1;
     @ (posedge sysclk);
     a_sysclk <= 1'b1; b_sysclk<= 1'b1;
     repeat(4) @ (posedge sysclk);
     @ (posedge sysclk);
     b_sysclk <= 1'b0;
     repeat(2) @ (posedge sysclk);
     ##100; $finish;
  end 

  
endmodule : testmatched1


