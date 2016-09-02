module m9_9(input clk, dgrant, dbusy_n, dbus_enb);
   // bit clk, dgrant, dbusy_n, dbus_enb;
    
    parameter MAX_CYCLES=256;
    
    property pDataGrantDbusy; 
        first_match ( $rose(dgrant) ##[0:255] dbusy_n[*2]) |=> dbus_enb;
    endproperty : pDataGrantDbusy
    apDataGrantDbusy: assert property(@(posedge clk)pDataGrantDbusy);

    property pDataGrantDbusy2;
        $rose(dgrant) |-> ##[1:MAX_CYCLES] (dbusy_n) [=2] ##1 dbus_enb;
    endproperty : pDataGrantDbusy2
    apDataGrantDbusy2: assert property(@(posedge clk)pDataGrantDbusy2);

    property pDataGrantDbusy3;
        $rose(dgrant) |-> ##[1:MAX_CYCLES] dbusy_n [->2] ##1 $rose(dbus_enb);
    endproperty : pDataGrantDbusy3
    apDataGrantDbusy3: assert property(@(posedge clk)pDataGrantDbusy3);

   
endmodule : m9_9
