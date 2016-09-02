/*
    Code for use with the book
    "SystemVerilog Assertions Handbook, 3nd edition"ISBN  878-0-9705394-3-6

    Code is copyright of VhdlCohen Publishing & CVC Pvt Ltd., copyright 2012

    www.systemverilog.us  ben@systemverilog.us
    www.cvcblr.com, info@cvcblr.com

    All code provided in this book and in the accompanied website is distributed
    with *ABSOLUTELY NO SUPPORT* and *NO WARRANTY* from the authors.  Neither
    the authors nor any supporting vendors shall be liable for damage in connection
    with, or arising out of, the furnishing, performance or use of the models
    provided in the book and website.
*/
module imm(input clk,push ,pop,output int fifo_count);
    timeunit 1ns;
    timeprecision 1ns;
    //logic clk, push, pop;
    //int   fifo_count;
    int   MAXCOUNT  =16;
    default clocking @(negedge clk); endclocking

    always @ (posedge clk) begin :Fifo_Counter
        /*PushPopTest:*/ if (push && !pop)  begin //CVC change -- commented  
            a_fifomax: assert (fifo_count < MAXCOUNT) else
            begin : Push_NoPop   // If  push and no pop then (fifo_count < MAXCOUNT)
                $display ("%m @ time %0t, push && ! pop && maxcount = %h"
                , $time, fifo_count);
            end  : Push_NoPop
            fifo_count <= fifo_count + 1'b1;
        end 
        else if (!push && pop) begin  // If  no push and pop then (fifo_count > 0)
            a_fifomin : assert (fifo_count > 0) else
            begin :Pop_NoPush
                $display ("%m @ time %0t, !push && pop && maxcount = %h", $time, 
                fifo_count);
            end : Pop_NoPush
            fifo_count <= fifo_count - 1'b1;   
        end
     end
endmodule : imm
