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
module top1; 

  logic clk, a, b, c;
an_conseq_matches dut(.*);

default clocking cb_clk @ (posedge clk);
   endclocking

  initial begin
   repeat(2) ##1;										 
   a<= 1'b1; b <=1'b0; c<= 1'b0;
   ##1; a<= 1'b0;  b<= 1'b1; c <=1'b0;
   ##1; a<= 1'b0;  b<= 1'b1; c <=1'b0;
   ##1; a<= 1'b0;  b<= 1'b1; c <=1'b1;
   ##1; a<= 1'b0;  b<= 1'b0; c <=1'b1;
   ##1; a<= 1'b0;  b<= 1'b1; c <=1'b0;  
    repeat (2) ##1;
   a<= 1'b0; c <=1'b0; c<= 1'b1;
   ##1; a<= 1'b0;  b<= 1'b1; c <=1'b1;
   ##1; a<= 1'b1;  b<= 1'b0; c <=1'b0;
   ##1; a<= 1'b0;  b<= 1'b0; c <=1'b0;
   ##1; a<= 1'b0;  b<= 1'b0; c <=1'b0;
   ##1; a<= 1'b0;  b<= 1'b1; c <=1'b0;
   ##1; a<= 1'b0;  b<= 1'b0; c <=1'b0;
   repeat (4) ##1;
   // 
   a<= 1'b1; c <=1'b0; c<= 1'b0;
   repeat(4) ##1;
   ##1; a<= 1'b0;  b<= 1'b1; c <=1'b1;
   ##1; a<= 1'b0;  b<= 1'b0; c <=1'b0;
   repeat (6) ##1;
   $display("end of simulation");
   $stop; 
 end  
 
endmodule :top1

