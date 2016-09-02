module m9_7(input clk, pkt_data_vld, first, lastbit );
   // bit clk, pkt_data_vld, first, lastbit;
    
    property pPacketLAstFirst; 
        $rose(pkt_data_vld && !first) |-> // preferred  style 
        strong( lastbit[->1]  ##[1:$] $rose(pkt_data_vld)  ##0  first); 
    endproperty : pPacketLAstFirst
    apPacketLAstFirst : assert property(@(posedge clk)pPacketLAstFirst);

    property pPacketLastFirst1; // No failure if end of simulation and lastbit does not occur
        first_match($rose(pkt_data_vld && !first) ##[1:$] lastbit)   |->
        strong( ##[1:$] ($rose(pkt_data_vld) && first)); 
    endproperty : pPacketLastFirst1
    apPacketLAstFirst1 : assert property(@(posedge clk)pPacketLastFirst1);

   endmodule : m9_7
