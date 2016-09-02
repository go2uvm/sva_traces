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
timeunit 1ns;
timeprecision 100ps;
  logic clk  , reset_n;
  logic [1:0] address; 
  //typedef logic [2:0] [1] flag_t;//CVC change commented
  logic [2:0] cache; // declares a memory array of 3 deep  1-bit
  logic [0:0] retire[0:2];
  `define VALID 1'b1
  `define INVALID 1'b0
  `define RETIRE 1'b1
    v9_17 dut(.*);
   initial forever #50  clk = !clk;
  initial begin
	for(int i=0; i<4; i++) begin
	  cache[i] 	 =0;
	  retire[i]  =0;
	end
  end
  default clocking @ ( posedge clk ); endclocking 
  initial begin
        address <= 2;     retire[address] <= 0; ##1;
     ##1;
        cache[address] = 1'b1;
     ##4; 
        retire[address] <= 1;
     ##3; 
        cache[address] = 1'b0;
     ##3;
	//
	 address <= 1;     retire[address] <= 0; 
     ##4;
	 cache[address] = 1'b1;
     ##4;
	 retire[address] <= 1;
     ##3; 
         cache[address] = 1'b1;
     ##23 ;
	$stop();

end 

endmodule : top1
						 
