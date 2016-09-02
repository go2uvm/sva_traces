module m_matched(input clk,clk1,a=0,b0,b,c,d,e);

    
    sequence q_ab;
        @ (posedge clk1) a ##1 @ (posedge clk) b; 
    endsequence : q_ab

    ap_ab:  assert property(@(posedge clk)
        disable iff(q_ab.triggered) c |=> d);

   // ap_ab_BUG:  assert property(@(posedge clk)
   //     disable iff(q_ab. matched) c |=> d); // .matched is illegal 

endmodule : m_matched
