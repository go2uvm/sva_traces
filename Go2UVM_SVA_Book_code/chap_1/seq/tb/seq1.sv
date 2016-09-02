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


module seq2;
    timeunit 1ns;
    timeprecision 1ns;
   logic clk=0,a,b,c,d,e,x,y;
    initial forever #10 clk=!clk; 
    // A default clocking block must be specified to use the ##n timing statement.
    default clocking cb_clk @ (negedge clk);  endclocking 
 // instantiate the dut
  seq1 DUT(.*) ;

    initial begin : test
        ##10 ;
        {a,b,c,d,e} = 5'b10000;
        ##1;
        {a,b,c,d,e} = 5'b01000; y = 1;
        ##1;
        {a,b,c,d,e} = 5'b00100;
        ##1;
        {a,b,c,d,e} = 5'b10000;
        ##1;
        {a,b,c,d,e} = 5'b10000;
        ##1;
        {a,b,c,d,e} = 5'b10000;
        ##1;
        {a,b,c,d,e} = 5'b10000;
        ##1;
        {a,b,c,d,e} = 5'b10000;
        ##1;
        $finish; 
    end : test
endmodule : seq2
