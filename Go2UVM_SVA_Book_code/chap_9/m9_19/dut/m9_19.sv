class C; 
    rand int done_dly, req_dly, ack_dly; 
    constraint done_dly_cst { done_dly >9 && done_dly <14 ;}
    // constraint req_dly_cst { delay >2 && delay <14 ;}
    constraint ack_dly_cst { ack_dly >1 && ack_dly <6 ;}
endclass : C
module m9_19(input clk,req,ack,done,status_reg);
   // bit clk, req, ack, done, status_reg; 
//reg temp;
    C c=new(); 
   // If req,  then either successful completion or error flag is set
    apReqAckDoneSuccess: assert property(@(posedge clk)
        first_match($rose(req) ##[1:5] ack ##[1:10] done)
        |=> (status_reg == 1'b0) );
    //If done ==1’b1 then apReqAckDoneFail is vacuous

    apReqAckDoneFail: assert property(@(posedge clk)
        $rose(req) |=> 
            first_match(!ack[*5] or !done[*10]) |-> (status_reg == 1'b1) );

    mp_req_frequency: assume property (@(posedge clk)req |=> !req[*1:9]);

   endmodule : m9_19
