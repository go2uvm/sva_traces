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
/* -----\/----- EXCLUDED -----\/-----
// Srini and Ajeetha,
// Can you fix my paragraph?  
Am not clear on this.  For example: 
checker a_chk(logic a, b, untyped max);
  a |-> ##[1:max] b; 
endchecker : a_chk 
 -----/\----- EXCLUDED -----/\----- */

module k(input w, y, clk);
 // timeunit 1ns;
//  timeprecision 1ns;
 // logic w, y, clk;
  int z;

 // always @ (posedge clk) begin
  initial begin    
    int j;
    for (int i=0; i<4; i++)
	 $display("i= %d, const'(i)=$d", i, i);
// const'(i));
   
//	 a_chk(w, y, i); //  ?? Need a const'(i) ??
                     // What does it mean with a const'(i) ?
//   j  = 3;
//   a_chk(w, y, j); // j passed by value,  ref?
//   z <= 4;
//   a_chk(w, y, z); // z passed by value,  ref?
 end
endmodule : k 


