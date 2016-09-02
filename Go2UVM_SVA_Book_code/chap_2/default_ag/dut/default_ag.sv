module default_ag(input clk,a, int unsigned k, m);
//int unsigned k=16'hF0F0,m;

    
    
    sequence q_with_default(logic w, untyped d=16'h0000, int unsigned x=16'hFF00, y=16'hFF00);
        w ##2 x==y ##1 x==d; 
    endsequence : q_with_default
    ap_q_with_default: assert property(@(posedge clk)q_with_default(a,k));
endmodule : default_ag
//
