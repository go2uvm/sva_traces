module mx(input clk,a,b,c,d,input [3:0]v);
       ap_1: assert property(@a a |=> b);
    ap_v: assert property(@v v==4'b0000 |=> a);
   
   // ap_t1: assert property( (@ (posedge clk) a##1 b) ##0 (c##1 d)); // line 7
    // # ** Error: temp.sv(7): (vlog-2046) Directive 'ap_t1' has un-clocked expressions or constructs. Please fix
    ap_t2: assert property( @ (posedge clk) (a##1 b) ##0 (c##1 d)); // OK 
    
        ap_vac: assert property(@(posedge clk)0 |-> 1) $display("vac");
//    ap_until: assert property(a until b);    
//    ap_untils: assert property(a s_until b);   
//    ap_untilw: assert property(a until_with b);     
    // initial $assertvacuousoff(0) ; 
    initial $assertpasson(0); 

//For example, the sequence of a read_request followed 
//    in one to two cycles later by a bus_request (the antecedent) 
//    should cause some consequent or effect to occur, 
//    such as an ack handshake followed by some data transfers. 
//    However, with no read_request or a failed bus_request response 
//    (perhaps because of an in-progress busy bus activity) 
//    the controlling FSM stays in the same state, i.e., 
//    the FSM does not progress to the data fetch sequence
    //ap_rd2done: assert property(read_request ##[1:2] bus_request |=> ack ##[1:10] done_data_xfr);
endmodule : mx
