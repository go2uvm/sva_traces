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
module top1;
    timeunit 1ns;
    timeprecision 1ns;
    logic clk, a, b, c, d;

    every_seq1_then_seq2 dut(.*);

    default clocking @(negedge clk); endclocking
    initial forever #5 clk = ~clk;

    initial begin
        ##1;  a<=0; b<=0; c<=0; d<= 1'b0;
        ##1;  a<=1; b<=0; c<=0; d<= 1'b0;
//        ##1;  a<=0; b<=1; c<=1; d<= 1'b1;
//        repeat(15) @ (posedge clk); 
        ##1;  a<=1; b<=1; c<=0; d<= 1'b0;
        ##1;  a<=0; b<=1; c<=1; d<= 1'b0;
        ##1;  a<=0; b<=0; c<=0; d<= 1'b0;
        ##1;  a<=1; b<=0; c<=0; d<= 1'b0;
// for(int i=0; i<=2; i++) ##1;
        ##1;  a<=0; b<=0; c<=0; d<= 1'b0;
        ##1;  a<=0; b<=1; c<=0; d<= 1'b0;
        ##1;  a<=0; b<=0; c<=1; d<= 1'b0;
        ##1;  a<=0; b<=0; c<=0; d<= 1'b0;   
        ##1;  a<=0; b<=0; c<=1; d<= 1'b1;
        ##1;  a<=0; b<=0; c<=0; d<= 1'b0;
        repeat(5) begin ##1;  a<=0; b<=0; c<=0; d<= 1'b0;
        end
        repeat (50) begin 
            if(!randomize(a, b, c, d))  $error("randomization failure"); 
            @ (posedge clk); 
        end 
        $stop;

        // max_range <= max_range+ 1;
        // for(int i=0; i<=5; i++) ##1;
    end   
endmodule : top1

