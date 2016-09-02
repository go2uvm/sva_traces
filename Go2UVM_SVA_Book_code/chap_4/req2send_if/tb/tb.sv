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

interface top1(input bit clk, reset_n);
    timeunit 1ns;
    timeprecision 100ps;
    logic request, ack;   // signals belonging to interface 
    logic [7:0] source_data, data_out; // signals belonging to interface
 


    req2send_if dut(.*);
default clocking @(posedge clk); endclocking

endinterface : top1




