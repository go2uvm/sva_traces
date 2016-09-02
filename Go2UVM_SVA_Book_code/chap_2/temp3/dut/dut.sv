module temp3(input clk, clk1, clk2, req, ack, done, crc_pass, crc_err, busy=1, ready=0,l_b, 
    req_data, reset, x, a=0,  b0, b, c, d, e, fx1=1, x0=0,bus_select, bus1, req1, ack1, req2, ack2); 
              ap_test_vac_message: assert property(@(posedge clk) 0 |=> 1)
        $display("ap_test_vac_message is vacuous");
    else $display("fail");
    ap_test_true_message: assert property(@(posedge clk)1 |=> 1)
        $display("ap_test_true_message");
    else $display("fail");

    property P2 
        (ack,  // argument , implicit untype
        sequence seq1,
        event evnt, // event identifier
        property P1,
        local int lv_data=0, 
        // local variable
        logic w  // argument, e.g., wire
        ); a |=> b;   
    endproperty : P2
//    initial begin
//        $assertoff(0); 
//        repeat(500) @ (posedge clk);
//        $asserton(0); 
//    end

    //ap1: assert property(P2);

    initial begin
        repeat(500) @ (posedge clk);
        forever  
        @ (posedge clk) 
            if (bus_select==bus1)
            ap_active_bus_delayed_bus1: assert property(@(posedge clk)
                if (bus_select==bus1)
                ($rose(req1) |=>  ##[0:5] ack1)); 
            else
            ap_active_bus_delayed_bus2: assert property( @(posedge clk)   
                ($rose(req2) |=>  ##[0:5] ack2));      
    end 


endmodule
