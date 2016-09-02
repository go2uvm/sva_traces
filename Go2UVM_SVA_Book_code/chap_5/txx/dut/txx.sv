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
module round_robin_chk2 (input  [7:0] req, grant,
                         input go, reset_n,input [2:0] counter,input clk);
timeunit 1ns;
timeprecision 1ns;
//  logic [2:0]     counter  = 0; // free checker variable
//  logic clk;
  
	ap_round_grant : assert property(@ (posedge clk) 
                 $rose(go) && req[counter] |-> ##[0:8] grant[counter]);
endmodule : round_robin_chk2     
