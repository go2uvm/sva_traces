module lce(input clk,clk0,clk1,clk2,a,b,c,d,e);
      // Illegal, no leading clocking event 
    ap_and2_seq_ERROR: assert property(@(posedge clk)
        (@ (posedge clk) a ##1 b) and 
        (c ##2 d));

    // Illegal, no leading clocking event
    // both sequences start concurrently 
    ap_and2_seq_ERROR2: assert property(@(posedge clk2)
        (@ (posedge clk2) a ##1 b) and 
        (@ (posedge clk2) c ##2 d));  // has multiple leading clocks for its maximal property

    // OK, one leading clocking event 
    ap_and2ab: assert property(@ (posedge clk2) 1|-> 
        (@ (posedge clk2) a ##1 b) and 
        (@ (posedge clk2) c ##2 d)   
        );

    // Illegal, no leading clocking event
    // both properties start concurrently 
    ap_and2_Prop_ERROR: assert property(@ (posedge clk2)
        (@ (posedge clk2) 1 |-> a ##1 b) and 
        (@ (posedge clk2) 1 |-> c ##2 d)   
        );
        
    // OK, Same leading clocking event
    // both properties start concurrently 
    ap_and2_Prop_OK_same_clk: assert property(
        (@ (posedge clk) 1 |-> a ##1 b) and 
        (@ (posedge clk) 1 |-> c ##2 d)   
        );

    ap_and2_Prop_OK: assert property(@ (posedge clk0) 1 |-> 
        (@ (posedge clk) 1 |-> a ##1 b) and 
        (@ (posedge clk2) 1 |-> c ##2 d)   
        );
        
    ap_mult_clk: assert property(
        @ (posedge clk2) a [*0:1] ##1@ (posedge clk2) b[*0:2] ##1 c); //  illegal b[*0] is empty
    
endmodule : lce
