module m9_4(input clk,req,ack,acquire,input [2:1] id=3'b000);
   // bit clk, req, ack, acquire;
   // bit[2:1] id=3'b000; 
   
    sequence q_req_d; @ (posedge clk) $rose(req) ##1 1'b1; endsequence : q_req_d
//    property pReqAck4 ;    
//        if (q_req_d.triggered) 
//            sync_accept_on(ack && id == 4) // vacuous success if ack && id==4, else  
//            !req [*0:$] until_with  ack && acquire; // at next cycle req==0 until acquire 
//    endproperty : pReqAck4      
//    apReqAck4: assert property(pReqAck4);

    sequence ack_id; @ (posedge clk) ack && id==4; endsequence : ack_id
    property pReqAck4b;  
        disable iff(ack_id.triggered)       // not same as the sync_accept_on 
        $rose(req) |=> !req [*0:$] ##1 ack && acquire;
    endproperty :  pReqAck4b
    apReqAck4b: assert property(@(posedge clk)pReqAck4b);
    
    property pReqAck4c;  
        disable iff(ack_id.triggered)       // not same as the sync_accept_on 
        $rose(req) |=> (!req [*0:$] ##1 ack) and 
                       (!req [*0:$] ##1 acquire);
    endproperty :  pReqAck4c
    apReqAck4c: assert property(@(posedge clk)pReqAck4c);

        
    

endmodule : m9_4
