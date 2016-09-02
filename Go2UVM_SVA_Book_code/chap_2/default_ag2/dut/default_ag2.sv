module default_ag2(input clk,clk2,a,int unsigned k,m);
//unsigned k=16'hF0F0
        sequence q_with_default(event ev=posedge clk2, logic w, untyped d=16'h0000, int unsigned x, y=16'hFF00);
        @ (ev) w ##2 x==y ##1 x==d; 
    endsequence : q_with_default
    ap_q_with_default: assert property(q_with_default(posedge clk2, a,2 , k));
endmodule : default_ag2
//
