module m(
    input  clk, req=1, ack, done, intrpt, reset_n,
    output hdk_err); 
    reg hdk_err;
    
	apReadyReq : assert property (@(posedge clk)req |=> ack)  else  
    begin  : apFail     // fail statatements 
        $error ("%m ack=, pReadyReq Failure ", $sampled(ack));
        $error ("Handshake ERROR");
        hdk_err <= 1'b1; // This can cause the testbench to take a reactive action
    end : apFail
    
 //   ap_done1: assert #0 (done) $error ("%m ack= ",ack);

    apReadyReq1 : assert property (@(posedge clk)req |=> ack)  else  
    begin  : apFail1     // fail statatements 
        $error ("%m ack=, pReadyReq Failure ", $sampled(ack));
        $error ("Handshake ERROR");
        hdk_err <= 1'b1; // This can cause the testbench to take a reactive action
    end : apFail1 // no ";"  //line 19

    apReadyReq2 : assert property (@(posedge clk)req |=> ack)  else  
        $error ("%m ack=, pReadyReq Failure ", $sampled(ack));


endmodule : m
