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
module s1b_fm1; 
    timeunit 1ns;
    timeprecision 1ns;
    logic clk=1, a=0, b=0, c=0;
 s1b_fm dut(.*);

      default clocking @(negedge clk); endclocking
    initial forever #5 clk = !clk; //CVC change added "delay"
    initial begin 
        a<= 1'b1; b <=1'b0; c<= 1'b0;
        ##1; a<= 1'b0; b <=1'b1; c<= 1'b1;
        repeat (6) ##1;
        a<= 1'b0; b <=1'b0; c<= 1'b1;
        ##1; a<= 1'b0; b <=1'b1; c<= 1'b1;
        repeat (3) ##1;
        a<= 1'b0; b <=1'b1; c<= 1'b0;
        repeat (3) ##1;
        $display("end of simulation");
        $stop; 
    end  

endmodule : s1b_fm1
