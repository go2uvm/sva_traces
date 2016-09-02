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
module seq_trigger31; 
  timeunit 1ns;
  timeprecision 1ns;
  logic clk , load_mem, done, ready, ready2;
  logic a;
 // assign a	= qDoneSetup.triggered;

seq_trigger3 dut (.*);
    default clocking @(negedge clk); endclocking
  initial forever #5 clk = !clk; 
  initial begin 
   repeat (100) ##1;;
   $display("end of simulation");
   $stop; 
   end

 //  always @ (posedge clk) assert (randomize(load_mem, done));
  initial begin
    ##1; load_mem <= 1'b1;
    ##1; load_mem <= 1'b0; done <= 1'b1;
   end

	
   
endmodule : seq_trigger31

				 		   







