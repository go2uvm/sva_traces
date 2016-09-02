module recursive(input clk,req,ack,done,transfer_envelope,parity_error);

        property reqack; 
        req |-> ack; 
    endproperty
    
    property prop_always(p);
        p and ( prop_always(p));
    endproperty
    ap_prop_always: assert property(@(posedge clk)prop_always(reqack));
        
endmodule : recursive

