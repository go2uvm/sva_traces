module if_else_prop(input  clk, bus_select, bus1, req1, req2,output ack1, ack2 );
        ap_active_bus : assert  property(@(posedge clk)
        if (bus_select==bus1)
        ($rose(req1) |=>  ##[0:5] ack1)
        else  
        ($rose(req2) |=>  ##[0:5] ack2));

endmodule : if_else_prop
