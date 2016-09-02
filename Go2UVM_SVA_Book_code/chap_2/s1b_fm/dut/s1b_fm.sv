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
module s1b_fm(input clk,a,b,c); 
    timeunit 1ns;
    timeprecision 1ns;

    ap_never_succeed: assert property(@ (posedge clk) 
        $rose(a) ##[2:$] b |=> c);
    ap_all_threads_for_success: assert property(@ (posedge clk) 
        $rose(a) ##[2:5] b |=> c);
    ap_FM_never_succeed: assert property(@ (posedge clk) 
        first_match($rose(a) ##[2:$] b) |=> c);
    ap_FM_all_threads_for_success: assert property(@ (posedge clk) 
        first_match($rose(a) ##[2:5] b) |=> c);  

endmodule : s1b_fm
