module m_eventually2(input clk, req, ack, done);
      
    ap_req_ack: assert property(@(posedge clk)$rose(req) |-> s_eventually ack); // Sim OK 
    // (s_eventually p)    equivalent to (not (always(not p))
    // (always p)            is equivalent to (p until 0).
    ap_req_ack_equivalent: assert property(@(posedge clk)$rose(req) |->  // SIM OK 
        //  (not (always(not ack)) );
        // (not (not ack until 0)));  
                                           ack[->1]);  
    ap_req_ack1_2: assert property(@(posedge clk) $rose(req) |-> s_eventually[1:2] $rose(ack) // ERROR, Passes nonvacuous at next cycle 
                                   |-> ##[1:2] done); // should be vacuous pass 
    ap_req_ack1_2_equivalent: assert property ( @(posedge clk) // ERROR, Passes nonvacuous at next cycle 
        $rose(req) |->(##1 1'b1 #-# $rose(ack) |-> ##[1:2] done) or 
                    (##2 1'b1 #-# $rose(ack) |-> ##[1:2] done)  // should be vacuous pass
        ); 
    ap_vac: assert property(@(posedge clk)$rose(req) |=> 0 |-> 1);  // OK 

    ap_or: assert property(@(posedge clk)req |=> (0 |-> 1));  // OK 
    
    endmodule : m_eventually2
