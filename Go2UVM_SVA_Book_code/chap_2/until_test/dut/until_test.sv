module until_test(
    input clk=1, req, busy, ready); 
    
    property pReqReady;      
        $rose(req) |=> busy until ready;     // Enhanced readability, and Identical to 
//   $rose(req) |=> busy[*0:$] ##1 ready ;   // equivalent property expression 
    endproperty : pReqReady
    apReqReady :  assert property (@ (posedge clk) 
        $rose(req) |=> busy until ready     // Enhanced readability, and Identical to 
        //   $rose(req) |=> busy[*0:$] ##1 ready ;   // equivalent property expression 
        );
        
    
    apReqReadyWith : assert property (@ (posedge clk) 
        $rose(req) |=> busy until_with ready 
        //   $rose(req) |=> busy[*0:$] ##1 ready && busy ;   // equivalent property expression 
        );

        

endmodule : until_test
