module m9_12(input clk, req, grant, frame, time_out, aquired);
           property pReqGrantTimeout;  
        (req && $rose(grant) ##1 (!frame && grant )[*63]) |-> (time_out); 
    endproperty : pReqGrantTimeout
    apReqGrantTimeout: assert property(@(posedge clk)pReqGrantTimeout);
    
    property pReqGrantAcquired;
       first_match( req && $rose(grant) ##1 
                   (!frame && grant )[*0:62] ##1 frame ) |-> aquired; 
    endproperty : pReqGrantAcquired
    apReqGrantAcquired: assert property(@(posedge clk)pReqGrantAcquired);
    
   
endmodule : m9_12
