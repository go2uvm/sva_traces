module new_file(input clk,req,frame,grant,output aquired);



property pReqGrantAcquired;
    first_match( req && $rose(grant) ##1 
        (!frame && grant )[*0:62] ##1 frame ) |-> aquired; 
endproperty : pReqGrantAcquired
endmodule : new_file
