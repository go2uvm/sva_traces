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
module d281(input clk,ack,done,status_reg,req); 
 
//reg clk,ack,done,status_reg,req;


// sequence needed to determine a successful completion with no errors
// ack within 5 cycles,  followed within 100 cycle by rose of done, and then no error flag
sequence qDoneSuccessful;
  ##[1:5] ack ##[1:100] $rose(done) ##0 (status_reg == 1'b0);
endsequence : qDoneSuccessful

// sequence needed to define an error flag
// no ack for 5 cycles, and no rose of done for 100 cycles, and then error flag 
sequence qError;
  !ack[*1:5]  ##1 !$rose(done)[*1:100] ##0 (status_reg == 1'b1);
endsequence : qError

// If req,  then either successful completion or  error flag is set
property pReqAckDoneFailOK;
  @(posedge clk)
     $rose(req) |->  qDoneSuccessful or  qError;       
endproperty : pReqAckDoneFailOK
endmodule :d281
       

