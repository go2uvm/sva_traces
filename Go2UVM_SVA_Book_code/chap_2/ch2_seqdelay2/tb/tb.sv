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
    timeunit 1ns;   timeprecision 100ps;
    logic clk=0, read=0, go=0, a=0, b=0, c=0;
    initial forever #10 clk=!clk; 
    int   max_range; 
  `define true 1'b1
    
 ch2seqdelay dut(.*);

 
default clocking @(negedge clk); endclocking

      
    initial begin
        ##1;  read<=0; go<=1; a<=0; b<=0; c<=0;
        ##1;  read<=0; go<=0; a<=1; b<=0; c<=0;
        ##1;  read<=0; go<=0; a<=0; b<=1; c<=0;
        ##1;  read<=0; go<=0; a<=0; b<=0; c<=0;

        // CVC - expect assertion to fail due to delay in "c" > 2
        ##10;

//  for(int i=0; i<=2; i++) ##1;;

        // CVC
        max_range <= 10;

        ##1;  read<=0; go<=0; a<=0; b<=0; c<=1;
        ##1;  c<=0;
        // max_range <= max_range+ 1;
        // CVC for(int i=0; i<=2; i++) ##1;
        ##3;

//##1;  read<=0; go<=0; a<=0; b<=0; c<=1;
        ##1; c<=0;
//  
        ##1;  read<=0; go<=1; a<=0; b<=0; c<=0;
        ##1;  read<=0; go<=0; a<=1; b<=0; c<=0;
        ##1;  read<=0; go<=0; a<=0; b<=1; c<=0;
        ##1;  read<=0; go<=0; a<=0; b<=0; c<=0;
        ##1;  read<=0; go<=0; a<=0; b<=0; c<=0; 
//  for(int i=0; i<=2; i++) ##1;;

        ##1;  read<=0; go<=0; a<=0; b<=0; c<=0;
        ##1;  c<=0;
        // max_range <= max_range+ 1;
        // CVC for(int i=0; i<=2; i++) ##1;
        ##3;
//##1;  read<=0; go<=0; a<=0; b<=0; c<=1;
        ##1; c<=0;
        ##1; $finish;   
    end
endmodule : top1

