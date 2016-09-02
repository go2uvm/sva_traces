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

module prop_seq1;
  timeunit 1ns;
  timeprecision 1ns;
 // import action_pkg::*;
  
  logic a, b, c;
  logic clk;
  logic ended_sig;
 prop_seq dut (.*); 

  // Clock
default clocking @(posedge clk);endclocking
   initial begin
	a = 0;
	b = 0;
	c = 0;
	clk = 1'b1;
	forever #10 clk = ~clk;
  end
  
  

initial begin : test
	int i;
	for (i=1; i<=5; i=i+1) begin
	  ##1; 
	end
     a <= 1'b1; b <= 1'b0; c <= 1'b0;
    ##1;
     a <= 1'b0; b <= 1'b0; c <= 1'b0;
    ##1;
     a <= 1'b0; b <= 1'b1; c <= 1'b1;
    ##1;
     a <= 1'b0; b <= 1'b1; c <= 1'b0;
    ##1;
    // FAILURE
     a <= 1'b1; b <= 1'b0; c <= 1'b0;
    ##1;
     a <= 1'b0; b <= 1'b0; c <= 1'b0;
    ##1;
     a <= 1'b0; b <= 1'b1; c <= 1'b0;
    ##1;
     a <= 1'b0; b <= 1'b1; c <= 1'b0;
    ##1;
    ##1;
    ##1;
    ##1;
    $finish;
  end
 
endmodule : prop_seq1  


