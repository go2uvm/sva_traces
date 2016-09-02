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
module counter (output logic[2:0] count_out, // counter output
                input  logic[2:0] data_in, // data to load 
                input  logic ld_enb, count_enb, rst_n, clk);
    timeunit 1ns; timeprecision 100ps;
    logic [2:0]  count;
    logic                      tc;
    assign count_out                   =count;
    assign tc                          = count==3'b111;

    default clocking @(negedge clk); endclocking
    always @ (posedge clk or negedge rst_n) 
    begin 
        if (!rst_n)         count <= 0;           
        else if (ld_enb)    count <= data_in; 
        else if (count_enb) count <= count_out + 1; 
    end                         
endmodule // counter
