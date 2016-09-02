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
  timeunit 1ns;                             
  timeprecision 100ps;    
  int total_sva_violations = 0;
  task report_sva_violation (string user_defined_err_msg );
    $display ("%0t SVA_VIOLATION: %m %s", $time, user_defined_err_msg);
    total_sva_violations ++; // A global status counter to count number of SVA violations.
  endtask : report_sva_violation
     endpackage : action_pkg

module m(input clk,reset_n,push1, pop1, fifofull);
logic fifocount_err;

   import action_pkg :: *;    // Import of package is visible by module only
  // code and property declarations
//timeunit 1ns;
//timeprecision 1ns;
//  logic reset_n, clk, push1, pop1, fifofull, fifocount_err;
  property pPushNoPop_FifoCount(rst_n, clk, push, pop, fifofull);
              @ (posedge clk) disable iff (!rst_n)
                not (push && !pop && fifofull); 
  endproperty : pPushNoPop_FifoCount                                
          
  apPushNoPop_FifoCount: assert property 
         (pPushNoPop_FifoCount(reset_n, clk, push1, pop1, fifofull)) 
  else 
    begin 
       report_sva_violation("Fifo push & no pop error");
      // fifocount_err <= 1'b1; // This can cause the testbench to take a reactive action
    end
endmodule : m
