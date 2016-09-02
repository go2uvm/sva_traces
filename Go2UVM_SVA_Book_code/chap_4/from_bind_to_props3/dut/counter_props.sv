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
module counter_props (
  input logic[2:0] count_out,  //  counter output    
  input  logic ld_enb, rst_n, 					               
  input  logic [2:0] count,        // internal design signal
  input  logic tc,                  // internal design signal
  input  logic clk
  );
   timeunit 1ns;   timeprecision 100ps;

   property p_tc;
    disable iff (!rst_n)
         (count)==3'b111 |-> tc; 
   endproperty : p_tc
   ap_tc : assert property(@ (posedge clk) p_tc) else
     $display ("0t error in terminal count", $time); 

   ap_counter : assert property( @ (posedge clk) tc |-> ##8 tc);
  default clocking @(negedge clk); endclocking
   
	    

endmodule : counter_props
