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
// Using modules instead of checker to verify compilation 
// checker as separate verification unit  in package 
//package sva_chkrs_pkg;
module unit_chk (input clk, input a, b, c, d, input int   r);
  timeunit 1ns;
  timeprecision 1ns;  
  logic e, f;  // local to checker 
  int 	j;  // local to checker
  sequence q1; a ##[1:5]b ##1 c[*2]; endsequence : q1
  property p1; a |=> c ##1 d; endproperty : p1
  // concurrent assertions
    ap1: assert property(@(posedge clk)p1) else $error("p1 error");
    cp1: cover property(@(posedge clk)p1); 
    //cq1: cover sequence (q1);
    cq1: cover property (@(posedge clk)q1);
  function void incr_j();
      if (a) j <= 0;
      else j++;
  endfunction : incr_j

  // procedural assertions 
    always  @(posedge clk) begin
        incr_j();
      im1: assert (b ==1 || r != j);  // immediate procedural assertion 
      ap_x: assert property (a |=> r==0) else $error("err in r value"); 
     // procedural concurrent assertion 
   end
endmodule : unit_chk
// endmodule : sva_chkrs_pkg

module top;
  // import sva_chkrs_pkg::*;
  timeunit 1ns;
  timeprecision 1ns;
logic clk_top, a1, b1, c1, d1;
  int 	r1;
    unit_chk my_checker1 (clk_top,  a1, b1, c1, r1); // checker instantiation at top level 
  dut dut1(.*);
endmodule : top

module dut; //CVC change added this module
  timeunit 1ns;
  timeprecision 1ns;
endmodule : dut
