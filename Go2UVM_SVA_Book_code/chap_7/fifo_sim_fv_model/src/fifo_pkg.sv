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
package fifo_pkg;
  parameter BIT_DEPTH = 4; // 2**BIT_DEPTH = depth of fifo 
  parameter FULL = 15;    // int'(2** BIT_DEPTH -1);
  parameter ALMOST_FULL = 10; // int'(3*FULL / 4);
  parameter ALMOST_EMPTY = 4;  //int'(FULL/4);
  parameter WIDTH = 32;
  typedef logic [WIDTH-1 : 0] word_t;
  typedef word_t [0 : (2**BIT_DEPTH-1)] buffer_t;
endpackage : fifo_pkg


