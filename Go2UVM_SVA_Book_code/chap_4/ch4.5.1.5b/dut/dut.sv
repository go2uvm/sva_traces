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
module q1_then_q2_after_5_clks(input clk, a,b,c,d);
  
  timeunit 1ns;
  timeprecision 1ns;

  sequence q1; a ##1 b; endsequence : q1
  sequence q2; c ##1 d; endsequence : q2

  property p_incorrect;
  int lv_count;
    @(posedge clk)
    (q1, lv_count = 0) |=> (1, lv_count += 1) [*0:$]
      |-> q2 |-> lv_count > 5;
  endproperty : p_incorrect
  
  cp_incorrect : cover property (p_incorrect);

  property p_incorrect_1;
  int lv_count;
    @(posedge clk)
    (q1, lv_count = 0) |=> (1, lv_count += 1) [*0:$]
      ##1 q2 |-> lv_count > 5;
  endproperty : p_incorrect_1
  
  ap_incorrect_1 : assert property (p_incorrect_1);

    // This fails as the temporal "and" fails at 110 ns
    
  property p_incorrect_2;
  int lv_count;
    @(posedge clk)
    (q1, lv_count = 0) |=> (1, lv_count += 1) [*0:$]
      ##1 q2 and lv_count > 5;
  endproperty : p_incorrect_2

  property p_corrected_2;
  int lv_count;
    @(posedge clk)
    (q1, lv_count = 0) |=> (1, lv_count += 1) [*0:$]
      ##1 (q2 and lv_count > 5);  // added the () // BEN
  endproperty : p_corrected_2	
  
  ap_incorrect_2 : assert property (p_corrected_2);


    // The following works fine, but no "counter"
  property p_correct_1;
    @(posedge clk)
    q1 |=> ##[4:$] q2;
  endproperty : p_correct_1
  
  ap_correct_1 : assert property (p_correct_1);

    
  property p_correct_count_2;
  int lv_count;
    @(posedge clk)
    q1 |=> ##4 (1'b1, lv_count = 5) 
      ##[0:$] (q2, $display ("%0t %m lv_count is %0d",
                             $time, lv_count))
        ##0 (1'b1, lv_count += 1,
                   $display ("%0t %m lv_count is %0d",
                             $time, lv_count))[*0:$];
    
  endproperty : p_correct_count_2
  
  ap_correct_count_2 : assert property (p_correct_count_2);

  // The following is CLOSEST to perhaps what user wanted?
  property p_correct_3;
    @(posedge clk)
    q1 ##[5:$] q2;
  endproperty : p_correct_3
  
  cp_correct_3 : cover property (p_correct_3);
    
    /*
  property p_correct_09;
  int lv_count;
    @(posedge clk)
    (q1, lv_count = 0) |=> 1'b1 ##1 (1, lv_count += 1) until  q2 
      |-> lv_count > 5;
  endproperty : p_correct_09
  
  ap_correct_09 : assert property (p_correct_09);
*/
  
endmodule : q1_then_q2_after_5_clks
