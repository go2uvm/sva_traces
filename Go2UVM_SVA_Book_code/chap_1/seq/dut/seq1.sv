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


module seq1(input clk,a,b,c,d,e,x,y);
    timeunit 1ns;
    timeprecision 1ns;
    bit clk , a, b, c, d, e, x, y;

    



// initial forever #10 clk=!clk; 
    // A default clocking block must be specified to use the ##n timing statement.
    default clocking cb_clk @ (negedge clk);  endclocking 
    sequence q_abc; @ (posedge clk) a ##1 b ##1 c; endsequence : q_abc
    sequence q_de; d ##[1:4]e; endsequence : q_de
    property p_abcde;
        q_abc |-> q_de;
    endproperty : p_abcde
    ap_abcde: assert property(@ (posedge clk) p_abcde);
    ap_qabc_de: assert property(@ (posedge clk) // see 2.5.2
        if (q_abc.triggered) d|=> e); // clocking event needed in the sequence declaration
// for compatibility with 1800-2009
// For 1800-2012 the inferred clocking event can be used for the .triggered function. Thus,
    sequence q_abc2012; a ##1 b ##1 c; endsequence : q_abc2012
    ap_qabc_de2012: assert property(@ (posedge clk)
        if (q_abc.triggered) d|=> e);

    endmodule : seq1
