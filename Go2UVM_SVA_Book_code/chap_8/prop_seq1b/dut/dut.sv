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
package action_pkg;

  timeunit 1ns;    timeprecision 100ps;                         

  int total_sva_violations = 0;

  task report_sva_violation (string user_defined_err_msg = "Error in SVA");

    $display ("%0t SVA_VIOLATION: %m %s ERR_COUNT: %0d", 
       $time, user_defined_err_msg,
       total_sva_violations);

    total_sva_violations ++; // A global status counter to count number of SVA violations[LJP1] .

  endtask : report_sva_violation

endpackage : action_pkg

module prop_seq(input a, b, c,clk,ended_sig);
timeunit 1ns; //CVC
timeprecision 100ps;
  import action_pkg::*;

    

  sequence qA23B;
  // @ (posedge clk) first_match( ##[2:3] b);
  @ (posedge clk) ( ##[2:3] b);  
  endsequence : qA23B
  

//property test_need_1stmatch(seq, c= posedge a); // OK 
// property test_need_1stmatch(seq, c= $past(a)); // ok
// property test_need_1stmatch(seq, c= $past(a));   // ok no sim ... terminated... 
// property test_need_1stmatch(seq, c= posedge a);  // ok, but no sim ??
property test_need_1stmatch(seq, c=1);   // sim ok 
  @ (posedge clk) 
    seq |-> c; 
 endproperty : test_need_1stmatch



  prop_seqtest: assert property (test_need_1stmatch(qA23B, c)) else
    report_sva_violation();
  prop_seqtest_same : assert property (test_need_1stmatch(qA23B, c)) else 
    report_sva_violation();

  endmodule : prop_seq  


