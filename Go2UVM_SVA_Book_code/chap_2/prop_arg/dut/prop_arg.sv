module prop_arg(input clk,ready=1'b1,request=1'b1,acknowledge,done);


        property p_req_ack(req, ack, N, sequence q_done);
        req |-> ##[1:N] ack ##1 q_done; 
    endproperty : p_req_ack

    property p_with_prop(property p); 
        ready |-> p; 
    endproperty : p_with_prop

    property p_top1;
        p_with_prop(p_req_ack(request, acknowledge, 5, done));  
    endproperty : p_top1
    ap_top1: assert property (@(posedge clk)(p_top1));

    property p_top2;
        p_with_prop(request |-> ##[1:5] acknowledge ##1 done);  
    endproperty : p_top2
    ap_top2: assert property (@(posedge clk)(p_top2));

    property p_top3;
        ready |-> p_req_ack(request, acknowledge, 5, done);  
    endproperty : p_top3
    ap_top3: assert property (@(posedge clk)(p_top3));
endmodule : prop_arg
