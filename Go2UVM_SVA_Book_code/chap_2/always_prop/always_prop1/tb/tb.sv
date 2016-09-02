

module after5001;
    logic clk, bus_select, bus1, req1, ack1, req2, ack2;
after500 dut(.*);
    //default clocking cb_clk @ (clk); endclocking 
  /* property p_active_bus;    
        if (bus_select==bus1)
            ($rose(req1) |=>  ##[0:5] ack1)
        else  
            ($rose(req2) |=>  ##[0:5] ack2);
    endproperty : p_active_bus
    // initial ap_active_bus : assert property(1'b1 ##500 #-# always p_active_bus);

    initial begin
        repeat(500) @ (posedge clk);
        forever 
        @ (posedge clk) 
            ap_active_bus : assert property(p_active_bus);
    end */

   default clocking @(negedge clk); endclocking



endmodule : after5001




/*module always_prop;
    logic clk, bus_select, bus1, req1, ack1, req2, ack2;
    default clocking cb_clk @ (clk); endclocking 
    property p_active_bus;    
        if (bus_select==bus1)
            ($rose(req1) |=>  ##[0:5] ack1)
        else  
            ($rose(req2) |=>  ##[0:5] ack2);
    endproperty : p_active_bus
    initial ap_active_bus : assert property(1'b1 ##500 #-# always p_active_bus);
endmodule : always_prop


module always_prop0;
    logic clk, bus_select, bus1, req1, ack1, req2, ack2;
    logic a, b, c; 
    default clocking cb_clk @ (clk); endclocking 
    //always [2:4] property_expr
    // let’s say for a given attempt ‘always’ evaluates a thread at times 20, 30 and 40.  
    // The one at 20 and the one at 40 have a non-vacuous pass and the one at 30 fails vacuously 
    // but it fails at a later time than the one that started at 40.  
    // As per the text of the LRM this would be a case for vacuous fail.

    ap_abc: assert property(always [3:4] a ##[1:4] b |-> c);
    ap_abc_eq: assert property( 
        (always [3:4] 
        (a ##1 b) or (a ##2 b) or (a ##3 b) or (a ##4 b) |-> c));


// (s_eventually p)    equivalent to (not (always(not p))
// (always p)            is equivalent to (p until 0).
    ap_req_ack_equivalent:assert property(
        $rose(req) |-> //  (not (always(not ack)) );
        (not ((not ack) until 0))); 

    (not ((not ack) until 0)));
    // (s_eventually p)    equivalent to (not ((not ack) until 0))
// (always p)            is equivalent to (p until 0).
    ap_req_ack_equivalent:assert property(
    $rose(req) |-> //  (not (always(not ack)) );
    (not (not ack until 0))); 

    generate
    begin : gen_1
    if (MODEL_ID==1) begin : mode1
    apD_r1 : assert property (@ (posedge clk)
        disable iff (!reset_n)
        d_r== $past(d));
        end : mode1 // if (MODEL_ID==1)
        else begin : mode2
        apD_r2 : assert property (@ (posedge clk)
        disable iff (!reset_n)
        load |=> d_r== $past(d));
        end : mode2 // else
        end : gen_conditional_assert
        endgenerate

        ap_ab: assert property(always (a |-> b));
            property p_active_bus;    
            1'b1 ##500 #-# if (bus_select==bus1)
            (always ($rose(req1) |=>  ##[0:5] ack1))
                else  
                (always ($rose(req2) |=>  ##[0:5] ack2));
                    endproperty : p_active_bus

                    initial 
                    ap_active_bus : assert  property(p_active_bus);

                    property p_inactive_bus;   
                    1'b1 ##500 #-# if (bus_select==!bus1)
                    (always (!req2 && !ack2))
                        else  
                        (always (not (req1 or ack1)));  // different style 
                            endproperty : p_inactive_bus

                            initial 
                            ap_inactive_bus: assert  property(p_inactive_bus);
                            endmodule : always_prop0 */

////Let m > 0. (always[m:m] p)    is equivalent to (nexttime[m] p).
////Let m < n. (always[m:n] p) is equivalent to  (always[m:n-1] p and nexttime[n] p).
////Let m > 0. (always[m:$] p    is equivalent to (nexttime[m] always p) .
//Let m > 0. (always[m:m] p)    is equivalent to (nexttime[m] p).
//Let m < n. 
//(always[2:4] p) is equivalent to  
//(always[2:3] p and nexttime[4] p)
//(always[2:2] p and nexttime [3] p and nexttime[4] p
// nexttime[2] p and nexttime [3] p and nexttime[4] p
//
// nexxtime (property_expression)[k] // equivalent to
//(strong(##k 1'b1) #-# property_expression
//(strong(##2 1'b1) #-# p) and 
//(strong(##3 1'b1) #-# p) and 
//(strong(##4 1'b1) #-# p) 


//
//Let m > 0. (always[m:$] p    is equivalent to (nexttime[m] always p) .

