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
// This testbench makes no attempt to ensure that the assumed properties are met. 
// In fact, the assumed properties are violated, thus resulting in errors.  
import fifo_pkg::*;
module fifo_tb; 
  timeunit 1ns;
  timeprecision 100ps;
   logic clk = 1'b0;   // system clock
   logic reset_n = 1'b0;
   
   // import fifo_pkg::*; // Access to package information
   // task_t thetask;	  // task to be performed, defined in client 
   
   fifo_if b_if(.*);		// instantiation of fifo interface
   

   fifo fifo_rtl_1(
             .clk          (clk),
             .reset_n      (reset_n), 
             .empty        (b_if.empty),
             .almost_empty (b_if.almost_empty),
             .almost_full  (b_if.almost_full),
             .full         (b_if.full),
             .data_out     (b_if.data_out),
             .error        (b_if.error),
             .data_in      (b_if.data_in),
             .push         (b_if.push),
             .pop          (b_if.pop)); // instantiation of fifo DUV

   // bind the fifo_rtl model to an implicit instantiation (fifo_props_1)
   // of property module fifo_props
   // bind fifo fifo_props fifo_props_1(clk, reset_n, b_if);

   // testbench code
   initial forever #50 clk = ~clk;
   default clocking  @ ( posedge clk );  endclocking
   task reset_task (int num);
	 begin
	 for (int i=0; i < num; i++) 
	   begin 
			  reset_n <= 1'b0;
			  ##1;
	   end
	 reset_n <= 1'b1;
	 ##1;
	 end
   endtask : reset_task 
   
   always // initial
   begin : client 
		 // directed tests
		   reset_task(5);
		 // 3 pushes
		 for (int i=0; i<= 3; i++) begin 
		   // push_task($random % WIDTH);
		  b_if.push_task($random );
		  b_if.idle_task($random % 5);
		  b_if.push_task(11 );
		 end

		 // 3 pop
		 for (int i=0; i<= 3; i++) begin 
		   b_if.pop_task;
		   b_if.idle_task($random % 5);
		 end

		 // push/pop random
		 for (int i=0; i<= 5; i++) begin
		   if ($random %2) begin
			 b_if.push_task($random % WIDTH);
			 b_if.idle_task($random % 3);
		   end
		   else begin
			 b_if.pop_task;
			 b_if.idle_task($random % 4);
		   end
		 end
		 // $stop;
		 end // block: client
   
/* -----\/----- EXCLUDED -----\/-----
		initial
		   $vcdpluson;
 -----/\----- EXCLUDED -----/\----- */
			
endmodule : fifo_tb

