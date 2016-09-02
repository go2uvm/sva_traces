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
module t(input clk, a, b, c, rst); 
 // timeunit 1ns;
//  timeprecision 1ns;
 // logic clk, a, b, c, rst;
  logic [7:0] [7:0] ix;
  logic [2:0]  i=3, j;

  property p1 (i,j);
    disable iff(rst) 
    (ix[i][j] |-> a );
  endproperty
  function logic t; 
    $info("test i=%b", i); 
    return 1; 
  endfunction : t 

  
  property p1n (i,j); // NOT A RECOMMENDED STYLE for errors, but legal 
    disable iff(rst) 
    ix[i][j] |-> (!a, $error("Failed") );
  endproperty 
  
  ap_p1: assert property(@ (posedge clk) p1(i, j)) else  $error("Failed");

  initial i=t(); 
endmodule : t

  
