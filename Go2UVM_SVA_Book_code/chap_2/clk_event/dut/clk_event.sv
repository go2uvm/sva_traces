module clk_event(input  clk, clk1, clk2, req, ack, done, crc_pass, crc_err, busy=1, ready=0, 
    req_data, reset, x, a=0,  b0, b, c, d, e, fx1=1, x0=0,
     a1=1, a2=1, a0, a4, a5, reset_n, x1, 
    input int i, j, input flag,input int data );


    
       property pXY(x,y, reset);  // active hi reset 
        int v;       
        disable iff (reset)  ( x, v=0) |=> y && v==data;
    endproperty : pXY
    sequence q_ab; @ (posedge clk) a ##1 b; endsequence : q_ab
    sequence q_ab2; @ (posedge clk1) a ##1 q_ab; endsequence : q_ab2
    apXY: assert property (@(posedge clk) 
                           pXY(req, ack, (q_ab.triggered))); //  disable iff expression is q_ab.triggered
    apXY_error1: assert property (@(posedge clk)
                                  pXY(req, ack, (q_ab2.matched))); //   illegal use of .matched 
//    apXY_error2: assert property (@(posedge clk) 
//                                  pXY(req, ack, (q_ab.ended))); // legacy   .ended is deprecated

    apXY_sampled: assert property (@(posedge clk) 
                pXY(req, ack, $sampled(reset)));   
    

     
    event ev; 
    always @ (posedge clk) 
        if(ready)
        ap_reqack_ready :  assert property (a |=>b);
//    always @ (ev)
//        if(ready)
//        ap_illegal_leading_clk_event :  assert property (a |=>b);

    sequence qS1; @(posedge clk) a ##1 b; endsequence : qS1

    ap_qs1: assert property(@(posedge clk)qS1 ##1 @ (posedge clk2) c ##1 d);

    //ap_qs2: assert property(qS1 ##1  c ##1 d);


endmodule
