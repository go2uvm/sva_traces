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
module ch2seqdelay(input clk=0, read=0, go=0, a=0, b=0, c=0,
        input int   max_range );
    timeunit 1ns;   timeprecision 100ps;
    
  `define true 1'b1
    

    // a ##[1:max_delay] c 
//    property p_seq_with_var_delay(max_count);  // 1 or greater                               
//        int v_cnt;
//        @(posedge clk)
//            (a, v_cnt=0)  |->  first_match((`true, v_cnt=v_cnt+1)[*1:$] ##1 (
//            v_cnt == max_count))  |->  c;    
//    endproperty : p_seq_with_var_delay
    property p_seq_with_var_delay(max_count);  // 1 or greater                               
        int v_cnt;
        @(posedge clk)
            (a, v_cnt=0)  |=>  c within  first_match((`true, v_cnt=v_cnt+1)[*1:$] ##0  
            (v_cnt == max_count)) ;         
    endproperty : p_seq_with_var_delay
    ap_seq_with_var_delay : assert property (p_seq_with_var_delay(max_range));


    endmodule : ch2seqdelay

