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
module  counttest (input clk,a,b,c,output d);
 int pass_count,cover_fail_count;
reg temp;
   // timeunit 1ns;  timeprecision 100ps;
   // int pass_count =0;  // all pass counts 
    //int cover_fail_count  =0;    // all fail counts
    //bit clk, a=1'b1, b, c, d; 
       
  //  default clocking cb_clk @ (posedge clk);  endclocking 

initial begin 
        $display("%t $assertpassoff(0)", $time); 
        $assertpassoff(0); // vacuous assertion pass statement are OFF 
        // $assertvacuousoff(0, counttest); // same as above
        // $assertvacuousoff (0, apCounter); // one specific assertion  
        repeat(20) @ (posedge clk); 
        $display("%t $assertpasson(0)", $time);  
        temp <= 1'b1; 
        $assertpasson(0);
assign temp=d;
    end 

   /* aptest: assert property(a |=> b) $display ("%t a=", $time, $sampled(a));
    apCounter: assert property (a  |=> b ##1 c) 
        pass_count++;
        else cover_fail_count ++;


always_ff begin
         @ (posedge clk) if(!randomize(a, b, c))  $error("randomization failure");
end*/
          
endmodule : counttest
