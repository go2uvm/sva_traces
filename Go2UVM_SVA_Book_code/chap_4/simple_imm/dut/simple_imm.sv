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
module simple_imm(input clk,push,pop,output full, output int fifo_count);
  parameter MAXCOUNT =8;

  
always @ (posedge clk) begin :Fifo_Counter
  /*PushPopTest:*/ if (push && !pop)  begin : if1 //CVC change commented "label"
    am1: assume (push && ! full) else $error("push when full"); // assumption about the environment 
    cv1:  cover(push && !full);    // coverage of this condition 
    ai_fifomax: assert (fifo_count < MAXCOUNT) else  // assertion of the fifo counter 
       begin : Push_NoPop
           $display ("%m @ time %0t, push && ! pop && maxcount = %h", $time, fifo_count);
          // fifo_count <= fifo_count + 1'b1;  // DO NOT DO THIS 
       end  : Push_NoPop
      fifo_count <= fifo_count + 1'b1; 
    end : if1
    else if (!push && pop) begin : if_else
    a_fifomin : assert (fifo_count > 0) else
            $display ("%m @ time %0t, !push && pop && maxcount = %h", $time, fifo_count);
    fifo_count <= fifo_count - 1'b1;   
  end : if_else
end : Fifo_Counter

endmodule : simple_imm

