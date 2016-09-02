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
module top2;
    timeunit 1ns;   
    timeprecision 100ps;
    logic clk,req,ack,done,status_reg; 
    // logic c.ack_dly,c.done_dly;
  initial forever #10 clk=!clk; 
   default clocking cb_clk @ (posedge clk);  endclocking 
      C c=new(); 
    // Instantiate the DUT
  m9_19 dut (.*);
 always begin
        @ (posedge clk); 
    if(!randomize(req, status_reg))  $error("randomization failure"); // req. A variable reference expected.status_reg.
        @ (posedge clk);
       req =1'b0; 
      if(!c.randomize())  $error("randomization failure");  
        repeat(2) @ (posedge clk);
        #2 if(!randomize(ack, done))  $error("randomization failure"); 
        if(!c.randomize())  $error("randomization failure");  
        repeat(2) @ (posedge clk); 
    end



     endmodule : top2



