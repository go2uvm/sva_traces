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
module testmatched(input clk, sysclk,a_sysclk,a_clk,b_sysclk,c,d_clk);
  timeunit 1ns;
  timeprecision 1ns;
  //logic clk  =1, sysclk=1, a_sysclk=1, a_clk=1, b_sysclk=1, c=1, d_clk=1;
  // IEEE 1800 2005, 17.7.10 Detecting and using endpoint of a sequence
  // IEEE 1800 2010, 16.14.5 Detecting and using end point of a sequence in multiclock context
  // Method triggered can also be applied to detect the end point of a sequence from within 
  // a multiclocked sequence. In both cases, the ending clock of the sequence instance 
  // to which triggered is applied shall be the same as the clock in
  // the context where the application of method triggered appears
  // [comment] triggered applied (@ sysclk)  triggered appears(@ clk)
  // Unlike triggered, matched provides synchronization between two clocks by storing 
  // the result of the source sequence until the arrival of the first clock tick 
  // of the destination sequence after the match.
  // [comment] The clock in the context where the application of method triggered appears
  // is the clock of the destination sequence after the match.  
  // ?? Or is it before the match? 
  sequence q1_sysclk;  @(posedge sysclk) a_sysclk ##1 b_sysclk;   endsequence : q1_sysclk
	
  // qOK is OK because, as result of clock flow, b_sysclk is clocked at sysclk.
  // Following that is there is multiclocking using the 
  // single-delay concatenation operator ##1
  sequence qOK; @ (posedge sysclk)  
     a_sysclk ##1 q1_sysclk.ended  ##1 b_sysclk ##1 @ (posedge clk) d_clk; 
  endsequence : qOK

  sequence qBUG; @ (posedge sysclk)  
     a_clk ##1 q1_sysclk.ended  ##1 d_clk; 
  endsequence : qBUG

  sequence qBUG2; @ (posedge sysclk)  
     a_clk ##1 q1_sysclk.ended ##1 d_clk; 
  endsequence : qBUG2

  sequence qMatched_OK; @ (posedge clk)  
     a_clk ##1 q1_sysclk.matched  ##1 d_clk; 
  endsequence : qMatched_OK

  sequence qMatched_OK2; @ (posedge sysclk)  
     a_clk ##1 @ (posedge clk) q1_sysclk.matched ##1 d_clk; 
  endsequence : qMatched_OK2		

  cp_qOK    : cover property(qOK);
  cp_qBUG   : cover property(qBUG);
  cp_qBUG2  : cover property(qBUG2);
  cqMatched  : cover property(qMatched_OK);
  cqMatched2 : cover property(qMatched_OK2);

  ap_qOK     : assert property(@ (posedge clk) qOK |=> 1);
  ap_qBUG    : assert property(@ (posedge clk) qBUG |=> 1);
  ap_qBUG2   : assert property(@ (posedge clk) qBUG2 |=> 1);
  aqMatched  : assert property(@ (posedge clk) qMatched_OK |=> 1);
  aqMatched2 : assert property(@ (posedge clk) qMatched_OK2 |=> 1);	
  
 
  
endmodule : testmatched


