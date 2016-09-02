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
module tb ;
  timeunit 1ns;
  timeprecision 1ns;

  logic clk =1'b1, request=0, acknowledge, data_enable, done;

 

  default clocking @(negedge clk); endclocking
  initial forever #5 clk=!clk;
  initial begin
      ##1; request <=1'b1;  acknowledge<=1'b0;
      data_enable <= 1'b0;  done<=1'b0;
      ##1; request <=1'b1;  acknowledge<=1'b1;
      data_enable <= 1'b0;  done<=1'b0;
      ##1; request <=1'b0;  acknowledge<=1'b1;
      data_enable <= 1'b1;  done<=1'b0;
      ##1; request <=1'b0;  acknowledge<=1'b0;
      data_enable <= 1'b0;  done<=1'b1;
      ##1; request <=1'b0;  acknowledge<=1'b0;
      data_enable <= 1'b0;  done<=1'b0;
      repeat(5) ##1;$finish; //CVC change-- changed "$stop" to "$finish"
	end 

	
endmodule : tb

