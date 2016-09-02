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
module assert_control (); 
   timeunit 1ns;
   timeprecision 100ps;
   initial begin : disable_assertions_during_reset
   $display ("%0t %m Disabling assertions during init..", $time);
   $assertoff (0, fifo_tb.fifo_rtl_1, fifo_if);
   @ (fifo_tb.reset_n === 1'b1);
      #1; // To avoid any race conditions
     $display ("%0t %m Enabling assertions after init..", $time);
     $asserton (0, fifo_tb.fifo_rtl_1, fifo_if);
   end
endmodule : assert_control
