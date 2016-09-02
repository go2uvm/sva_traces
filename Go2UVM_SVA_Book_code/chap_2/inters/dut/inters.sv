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
module inters(input clk,clk2,a,b,c,d,e,f);
  

    // Asserting on an illegal multiply clocked temporal expression. 
    // The clock flow cannot change in the RHS of 'intersect' operator.
//    apxx: assert property(
//   @ (posedge clk) e |-> (a ##1 b) intersect (@ (posedge clk2) c ##1 d)); //  
//    

    apxxOK: assert property(
        @ (posedge clk) e |-> (a ##1 b) intersect (e ##1 @ (posedge clk2) c ##1 @ (posedge clk) d)); //  


endmodule : inters
