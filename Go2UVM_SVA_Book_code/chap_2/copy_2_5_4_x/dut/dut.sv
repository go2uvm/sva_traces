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
module test2_5_4(input clk=1, req=0, ack=0, xfr=0);
    timeunit 1ns;
    timeprecision 1ns;

   // logic clk=1, req=0, ack=0, xfr=0;

    property pReqAck(req, ack, upper); 
        int v_ack_count;  //  local variable for the ack count 
        (req, v_ack_count = 1)  |=>  // If request, initialize  counter  
//          (v_ack_count < upper && !ack, v_ack_count += 1)[*0:$]  ##1 ack;  // Illegal
        ack or ((v_ack_count < upper && !ack, v_ack_count += 1)[*1:$]  ##1 ack);                          
    endproperty : pReqAck
    apReqAck : assert property(@ (posedge clk) pReqAck($rose(req), ack, 4));

//Note: The use of sync_reject_on(!xfr) ensures a failure if xfr==0.  
// Without the sync_reject_on(xfr) and with xfr==0 the consequentwith keep on searching for a match 
    property pAckDone(ack, xfr, rep); 
        int v_xfr_count;  //  local variable for the xfr count 
        (ack, v_xfr_count = 1) |=> // Reset v_xfr_count to count number of data transfers 
        sync_reject_on(!xfr)  // If no transfer, then it's an error 
        //(xfr && (v_xfr_count < rep), v_xfr_count += 1)[*0:$] // Illegal 
        // ##1 v_xfr_count==rep; // ends the repeat
        v_xfr_count==rep or 
        ((xfr && (v_xfr_count < rep), v_xfr_count += 1)[*1:$] ##1 v_xfr_count== 
        rep); 
    endproperty : pAckDone
    apAckDone : assert property(@ (posedge clk) pAckDone($rose(ack), xfr, 2));  
   

endmodule : test2_5_4  

