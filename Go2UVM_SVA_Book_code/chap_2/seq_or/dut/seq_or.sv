module seq_or(input clk,a,c,int b,d,e);
 // bit clk, a=1'b1, c=1'b1; 
 // int b=1, d=2, e=1; 
        sequence q2_or_2_threads;   
        int v; 
        ( ((a, v=1) ##1 b==v) or  // v==1 for this thread
        ((c, v=2) ##2 d==v) )    // v==2 for this thread
        ##1 e==v;    //  concatenation of each thread of or
    endsequence : q2_or_2_threads

    //ap_or: assert property((q2_or_2_threads) ##1 c);

endmodule : seq_or
