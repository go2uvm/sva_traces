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
module counter_tb1;
  timeunit 1ns;   timeprecision 1ns;
    logic  ld_enb; 
    logic data_in; 
    logic  count_out; 
    logic  count_enb; 
    logic  clk; 
    logic  rst_n;
    initial forever #10 clk=!clk; 
   
  counter_tb dut(.*);
  default clocking @(negedge clk); endclocking
  initial begin
        ##1;
	data_in   <= 8'hF0;
	ld_enb 	  <= 1;
	count_enb <= 1'b1;
	##1;
	ld_enb <= 1'b0;
	end 

endmodule : counter_tb1

