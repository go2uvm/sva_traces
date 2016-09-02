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
module throughout1(input clk,a,b,c);
  timeunit 1ns;
  timeprecision 1ns;
 // logic clk=1'b1, a=1'b0, b, c=1'b1;
  
  sequence qAB; 
      a[*1:2] ##1 b; 
  endsequence : qAB
  property pAB;
    $rose(a) ##0 (a throughout b[*3]); 
  endproperty : pAB
  // cpAB:  cover sequence  (@ (posedge clk) pAB); 
  cpAB:  cover property (@ (posedge clk) pAB);
  

endmodule : throughout1

