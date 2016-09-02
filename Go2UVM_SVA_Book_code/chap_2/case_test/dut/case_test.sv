module top2(input clk, ack1, ack2, req1, req2, bus_switch, 
    input[1:0] bus_select); 
    
property p_active_bus; 
        disable iff (bus_switch) 
        case (bus_select)
            2'b01 :  $rose(req1) |->  ##[1:5] ack1;
            2'b10 :  $rose(req2) |->  ##[1:5] ack2;
    default: 0; // forces a failure if none of the case items match.  
   // With no default and no case item match, then property succeeds vacuously
        endcase;
    endproperty : p_active_bus
  
    ap_active_bus0 : assert property(@(posedge clk)p_active_bus);
    ap_active_bus : assert property(@(posedge clk)
        disable iff (bus_switch) 
        case (bus_select)
        2'b01 :  $rose(req1) |->  ##[1:5] ack1;
        2'b10 :  $rose(req2) |->  ##[1:5] ack2;
        default: 0; // forces a failure if none of the case items match.  
        // With no default and no case item match, then property succeeds vacuously
        endcase);


endmodule : top2
