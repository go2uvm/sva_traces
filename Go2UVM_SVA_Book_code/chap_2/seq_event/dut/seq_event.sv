module seq_event(input clk,clk2,a,b,c);
   // bit clk, clk2;
    //logic  a=1'b0, b=1'b0, c=1'b1; 
       sequence q_abc;
        @(posedge clk) a ##1 b ##1 c;
    endsequence : q_abc
    sequence q_e(event e);
        @ (e) $rose(b) ##1 c;  
    endsequence : q_e 
    ap_qe: assert property(@ (posedge clk) a |-> q_e(posedge clk2));
    ap_qe_match0: assert property(
        @ (posedge clk) $rose(a) |-> q_e(posedge clk2).matched
        );
    ap_qe_match: assert property(
        @ (posedge clk) $rose(a) |-> q_e(posedge clk2).matched  
                                 ##1 a);
    ap_qseq: assert property(@ (posedge clk) a |-> q_e(q_abc));
   
   ap_t: assert property(@ (q_abc) c );
endmodule : seq_event
