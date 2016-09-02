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
module every_seq1_then_seq2(input clk, a=0, b=0, c=0, d=0); // 
    timeunit 1ns;
    timeprecision 1ns;
    int an_tag=0;  // antecedent count 
    int co_tag=0;  // consequent count 

    function void inc_an_tag;
        an_tag++;
        $display("an_tag= %0d, time=%t", an_tag, $time);
    endfunction:inc_an_tag

    function void inc_co_tag;
        co_tag++;
        $display("co_tag= %0d, time=%t", co_tag, $time);
    endfunction:inc_co_tag

    property p_an_co_match;  
        int v_tag;
        first_match($rose(a) ##[1:5] (b, v_tag =an_tag, inc_an_tag)) |=>   
        c ##[2:10] (d  && v_tag==co_tag, inc_co_tag);   
    endproperty : p_an_co_match
    ap_an_co_match: assert property (@ (posedge clk) p_an_co_match) else 
    begin 
        co_tag++; // inc_co_tag;
        $display("co_tag increment thru fail = %0d, time=%t", co_tag, $time);
   
  //  ap_1co_ends_attempt: assert property(
     //   @ (posedge clk) first_match($rose(a) ##[1:5] b)  |=> c ##[2:10] d);
end
endmodule : every_seq1_then_seq2


