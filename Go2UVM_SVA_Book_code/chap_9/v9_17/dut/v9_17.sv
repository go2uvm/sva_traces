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
module v9_17(input   clk  =1, reset_n=1,
  input [1:0] address, input [2:0] cache, 
 input  [0:0] retire[0:2]
); 
  //logic clk  =1, reset_n=1;
//  logic [1:0] address; 
  //typedef logic [2:0] [1] flag_t;//CVC change commented
 // logic [2:0] cache; // declares a memory array of 3 deep  1-bit
 // logic [0:0] retire[0:2];
  `define VALID 1'b1
  `define INVALID 1'b0
  `define RETIRE 1'b1
  property pValidRetire;
    int v_address;
     disable iff (!reset_n) 
    ($rose(cache[address]==`VALID), v_address= address) |-> 
     (retire[v_address]==`RETIRE[->1]  
         ##[2:7] cache[v_address]==`INVALID);
   endproperty : pValidRetire
    apValidRetire : assert property(@ (posedge clk) pValidRetire);
	   
  // initial forever #50  clk = !clk;

//  default clocking @ ( posedge clk ); endclocking 
 


endmodule : v9_17
						 
