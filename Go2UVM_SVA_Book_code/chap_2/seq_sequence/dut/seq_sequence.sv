module seq_sequence(input clk, clk2,a=1,b=1,c=1,d=1,e=1,f=1,a8=0,b8=8'hff, int i,j);
   // bit clk, clk2, a=1, b=1, c=1, d=1, e=1, f=1; 
   // bit[7:0] a8=0, d8=8'hff; 
   // int i, j; 
     
       sequence q_untyped(w, y);
        @ (posedge clk) w ##2 y; 
    endsequence : q_untyped

    sequence q_seq(logic w, sequence q);
        @ (posedge clk) w ##2 q; 
    endsequence : q_seq  

   /* ap_seq1: assert property($rose(c) |-> q_seq(e, q_untyped(a, b)));
    ap_seq2: assert property($rose(c) |-> q_seq(e, a ##2 b));
    ap_bool: assert property(q_seq(a, b||c));
    ap_test_trig: assert property(q_seq(a, q_untyped(e,f).triggered));
    ap_test_matched: assert property(q_seq(a, q_untyped(e,f).matched));  
    ap_seq1_trig: assert property($rose(c) |-> 
        q_seq(e, q_untyped(a, b).triggered));
    ap_seq2_trig: assert property($rose(c) |-> q_seq(e, a ##2 b));
    //
    ap_seq3_trig: assert property($rose(c) |-> 
            q_seq(e, @ (posedge clk) (a ##2 b)).triggered));  // line 27 
    // ** Error: seq_sequence.sv(27): near ".": syntax error, unexpected '.', expecting ')'*/
  /*  always @ (posedge clk)
    begin 
        if(!randomize(b, c))  $display("randomization failure"); 
    end*/

endmodule : seq_sequence
