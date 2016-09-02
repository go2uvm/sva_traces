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
 
 
  typedef enum {OFF, RED, YELLOW, GREEN, PRE_GREEN} lights_t;
  //...  // additional declarations shared by multiple design blocks
  // endpackage : common_declarations_pkg

module my_module2 (input  [31:0] a,
                 input   clk,k,
                 input [31:0] b);
 // import common_declarations_pkg ::*;  // import declarations from the package
  timeunit 1ns;
  timeprecision 100ps;
 
  lights_t lights; 
  // local variable used inside this module
  property pTest; @ (posedge clk) (lights==YELLOW) |=>a==b; endproperty : pTest
  apTest  : assert property (pTest);
  //...  // additional code with the model functionality
endmodule : my_module2
