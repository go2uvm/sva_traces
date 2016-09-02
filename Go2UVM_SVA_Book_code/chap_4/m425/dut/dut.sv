module m425(input x=1, y=1, clk, enb, enb0=0, enb1=1, a1=1, b1, c1, d1, e1, f1,en, en1, a, b, c, reset_n, d, e, f,ev,enb_local);
    assign en1= a && b; 
      // initial forever #10 clk=!clk; 

    cp_or1: cover property(@ (posedge clk)
    a1 |=> (c1 |-> d1) or (e1|->f1))
    $display("cp_or1:: @ %t, $past(a1)=%b, c1=%b, d1=%b, e1=%b, f1=%b", 
    $time, $past(a1),  $sampled(c1), $sampled(d1),  
    $sampled(e1), $sampled(f1)); 
    cq_a1c1d1: cover sequence(@ (posedge clk) a1 ##1 c1 ##0 d1); 
    cq_a1e1f1: cover sequence(@ (posedge clk) a1 ##1 e1 ##0 f1); 

    
    // test
//    task test(); // illegal 
//        ap_test_tasks: assert property(@ (posedge clk) a1 |=> b1 );
//        
//    endtask : test
    always @(posedge clk) begin : alwy1
                if(enb) 
        ap_OK: assert property (x |=> y );
        if ($sampled(enb)) 
        ap_sampled: assert property (x |=> y );  
        // equivalent to:  (en |-> x |=> y)
        ap_en: assert property(enb);
           end : alwy1
    
    always @(posedge clk) begin : alwy_auto
        automatic bit enb_local  = enb1;
        if(enb_local) 
        ap_OK_auto: assert property (x |=> y );
//        if ($sampled(enb_local)) 
//        ap_sampled: assert property (x |=> y );  
        // equivalent to:  (en |-> x |=> y)
        ap_en_auto: assert property(enb_local);
        enb_local=enb0; 
    end : alwy_auto
//    always @(e) begin : a1b
//        en   = 1'b1;
//        if(en || en1) ap_OK: assert property (x |=> y );
//            if ($sampled(en)) 
//            ap_sampled: assert property (x |=> y );  
//            // equivalent to:  (en |-> x |=> y)
//    end : a1b
   ai_1: assert property (@(posedge clk) en==1); 
    ap_t: assert property(@(posedge clk) a |=> b);
    cp_df: cover property(@ (posedge clk) d |=> f) $display("cp_df"); 

   //    mp_reset_at_init : assume property (@(posedge clk)
//    !reset_n[*5] #-# always(reset_n) );

    cp1: cover property(@ (posedge clk) a[*1:2] |=> b) $display("cp1"); 
    cq_ab: cover sequence (@ (posedge clk) a[*1:2] ##1 b) 
    $display("cq_ab at t= %t", $time); 
    cq_fm_ab: cover sequence (@ (posedge clk) 
    first_match (a[*1:2] ##1 b)) 
    $display("cq_fm_ab at t= %t", $time); 
    cp_ab: cover property (@ (posedge clk) 
    (a[*1:2] ##1 b)) $display("cp_ab at t= %t", $time); 
    // Another approach
//    initial 
//    ap_reset_then_hi : assume property ( @ (posedge clk)
//    !reset_n[*1:100] ##1 reset_n |=>  always (reset_n));
    // The leading clocking event @ (posedge clk)  gets forwarded into the consequent


endmodule : m425   

