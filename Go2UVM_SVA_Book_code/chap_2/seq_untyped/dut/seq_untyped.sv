module seq_untyped(input clk,
    a, b=1, c, d, e, f=1, 
   [7:0] a8=0, d8=8'hff, 
    int i, j); 
       
    sequence q_untyped(w, y);
        w ##2 y; 
    endsequence : q_untyped

   /* sequence q_logic_untyped(logic w, x, untyped y);
        (w != x) ##2 y; 
    endsequence : q_logic_untyped*/

    // equivalent to (not (a!=b ##2 a8==8'FF) ) 
   // ap_never_q_logic_untyped: assert property(
        //not(q_logic_untyped(a, b, a8==8'hFF))
        

    sequence q_abc;
        $rose(a) ##1 b[->1] ##1 c; 
    endsequence : q_abc

    sequence q_mn(m, n);
        m==n; 
    endsequence : q_mn 

    // equivalent to ($rose(e) |-> a ##2 b) 
    //ap_bits: assert property($rose(e) |-> q_untyped(a, b));

    // equivalent to ( b ##2 a8==d8) |-> f 
    //ap_bits2: assert property(q_untyped(b, a8==d8) |-> f);

    // equivalent to $rose(f) |-> ($rose(a) ##1 b[->1] ##1 c) ##2  (d==e)
   // ap_sequences: assert property($rose(f) |-> q_untyped(q_abc, 
       // q_mn( d, e)));

    // equivalent to $rose(e) |-> i==j
   // ap_int: assert property($rose(e) |-> q_mn(a8, d8));

    // OK in 1800-2012
    sequence q_delay(a, b, min, max, delay1);
        a ##delay1 b[*min:max];
    endsequence
    // equivalent to e ##2 f[*3:$] 
  //  a1: assert property (q_delay(e, f 3, $, 2));


   // int z=3, k=2;
    // Illegal: z and k are not elaboration-time constants
    // a2_illegal: assert property (@(posedge clk) q_delay(e, f, z, $, k));
endmodule : seq_untyped

//For example, a reference to an untyped formal argument may appear in the specification of a
//cycle_delay_range, a boolean_abbrev, or a sequence_abbrev (see 16.9.2), only if the actual argument is an
//elaboration-time constant. The following example illustrates such usage of formal arguments:


