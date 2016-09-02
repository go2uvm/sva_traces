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
module s1c_ep(input clk,a,b,c); 
    timeunit 1ns;
    timeprecision 1ns;
    

//Which is best to write: 
//1) end point of a first match of a sequence, i.e., 
    sequence q_ab; @ (posedge clk) a ##[1:3] b; endsequence  
    sequence q_abFM; @ (posedge clk) first_match(a ##[1:3] b); endsequence 
    ap_q_abFM_triggered: assert property(@ (posedge clk)  q_abFM.triggered |=> 1);    

// 2) first match of end points of a sequence  
    ap_FMq_ab_triggered: assert property(@ (posedge clk)  
        first_match(q_ab.triggered ) |=> 1);

    sequence qa1b; @ (posedge clk) a ##1 b; endsequence
    sequence qa2b; @ (posedge clk) a ##2 b; endsequence
    sequence qa3b; @ (posedge clk) a ##3 b; endsequence
    sequence qab123_triggered;  @ (posedge clk) 
    qa1b.triggered or qa2b.triggered or qa3b.triggered;  endsequence 
    ap_qab123_triggered: assert property(@ (posedge clk)   qab123_triggered |=> 1);
    ap_FMqab123_triggered: assert property(@ (posedge clk) 1 |=> 
        first_match(qab123_triggered));

 

   
endmodule : s1c_ep

