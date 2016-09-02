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
module d17(input clk,read,write,rd_served,interrupt,wr_served ); 
//  timeunit 1ns;
  //timeprecision 100ps;
//reg clk,read,write,rd_served,interrupt,wr_served;
property pNeverReadWrite;  
  @ (posedge clk) not (read && write);
endproperty : pNeverReadWrite

 property pReadSchedule;
        @ (posedge clk)  $rose(read) |-> (##[1:5]rd_served) or (##[1:5] interrupt); endproperty : pReadSchedule
  property pWriteSchedule;   
     @ (posedge clk)  $rose(write) |-> (##[1:5]wr_served) or (##[1:5] interrupt); endproperty : pWriteSchedule
sequence  qNewInterrupt; 
  @ (posedge clk) ##[0:$] $rose(interrupt);
endsequence : qNewInterrupt
  /* property pReadSchedule1;
   @ (posedge clk) disable iff (qNewInterrupt.triggered )
         $rose(read) |-> (##[1:5]rd_served);
 endproperty : pReadSchedule1

property pReadWriteIntrpt ;
  @ (posedge clk) disable iff (qNewInterrupt.triggered)
   ($rose(read) || $rose(write)) |-> (##[1:5] ##1 (rd_served || wr_served ));
   endproperty : pReadWriteIntrpt*/

endmodule :d17
