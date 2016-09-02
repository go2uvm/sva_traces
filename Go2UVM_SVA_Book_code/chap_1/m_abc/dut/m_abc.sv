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
`timescale 1ns/1ns

module m_abc(input clk=1'b1, a=1'b0, b, c=1'b0 );
  timeunit 1ns;
  timeprecision 1ns;
 // logic clk=1'b1, a=1'b0, b, c=1'b0;

  sequence qAB2C; 
      @(posedge clk) $rose(a) ##1 b ##2 c; 
  endsequence : qAB2C

  ap_qAB2C:  assert property (@ (posedge clk) qAB2C);
  
 

endmodule : m_abc

