module mux_bus(input clk,bus_select,bus1,req1,req2,rst_n,output ack1,ack2);
       
    property p_active_bus;    
        if (bus_select==bus1)
            // (always ($rose(req1) |=>  ##[0:5] ack1))
            ($rose(req1) |=>  ##[0:5] ack1)
        else  
            // (always ($rose(req2) |=>  ##[0:5] ack2));
             ($rose(req2) |=>  ##[0:5] ack2);
    endproperty : p_active_bus

    initial  
    ap_active_bus : assert  property(@(posedge clk)##500 1'b1 #-# p_active_bus);

//    property p_inactive_bus;   
//        if (bus_select==bus1)
//            (always (!req2 && !ack2))
//        else  
//            (always (not (req1 or ack1)));  // different style 
//    endproperty : p_inactive_bus
//
//    initial : inactive_bus
//    ap_inactive_bus: assert  property(##500 1’b1 #-# p_inactive_bus);

endmodule : mux_bus
