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
module reqack_chk(input clk,reset_n, input [1:0]req,output [1:0]ack, done,input enb,input intrpt); 
   
   ap_reqack: assert property(@ (posedge clk)
   req |-> ##[1:5] ack ##1 done);
endmodule : reqack_chk

module m (input clk,reset_n ,input [1:0]req,output [1:0]ack, done,input enb,input intrpt);

  //logic clk, enb, reset_n;
 // logic [1:0] req, ack, done, intrpt;  
// always @ (posedge clk) begin : a1
 // if (enb) 
reqack_chk dut1 (.*);
  //  end : a1 
endmodule : m


