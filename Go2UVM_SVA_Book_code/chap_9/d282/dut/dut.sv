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
module d282(input clk,req,ack,done,status_reg); 
  timeunit 1ns;
  timeprecision 100ps;

//reg clk,req,ack,done,status_reg;
reg ReqAckDoneFail;

property pReqAckDoneFail ; 
   @ (posedge clk) 
       not ($rose(req) ##[1:5] ack |-> ##[1:100] done ##0 (status_reg == 1'b0));  
endproperty : pReqAckDoneFail


property pReqAckDone; 
   @ (posedge clk) req |-> ##[1:5] ack ##[1:100] done;
endproperty : pReqAckDone

apReqAckDone_1 : assert property (pReqAckDone) else begin 
    ReqAckDoneFail <= 1'b1; // generate one pulse on signal ReqAckDoneFail
    @ (posedge clk) ReqAckDoneFail <= 1'b0; 
    end 

property pStatusRegOnError; 
  @ (posedge clk) 
    ReqAckDoneFail |=> status_reg == 1'b1; 
endproperty : pStatusRegOnError

apStatusRegOnError_1 : assert property (pStatusRegOnError);

endmodule :d282

