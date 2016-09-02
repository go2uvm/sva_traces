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
module sect1_6_4_1(input clk,push,pop,output int fifo_count);
 
  
class c;
 // logic clk, push, pop;
  //int 	fifo_count;
  int 	MAXCOUNT  =16;
  
  task t;
    @ (posedge clk) begin :Fifo_Counter
       /*PushPopTest:*/ if (push && !pop)  begin : b1a //CVC change commented
          a_fifomax: assert (fifo_count < MAXCOUNT)  else
            begin : Push_NoPop   
             // If  push and no pop then (fifo_count < MAXCOUNT)
             $warning ("%m @ time %0t, FIFO overflow: maxcount = %h", $time, fifo_count);
            end  : Push_NoPop
          fifo_count = fifo_count + 1'b1;
          end : b1a 
        else if (!push && pop) begin  : b1b// If  no push and pop then (fifo_count > 0)
            a_fifomin : assert (fifo_count > 0) else
			begin :Pop_NoPush
	         $warning ("%m @ time %0t, FIFO underflow:  maxcount = %h", $time, fifo_count);
           end : Pop_NoPush
           fifo_count = fifo_count - 1'b1;
		end : b1b
	  end : Fifo_Counter
  endtask : t
 endclass : c
endmodule : sect1_6_4_1
