module type_m(input clk,a,b,c,real r1,r2, shortreal sr1,sr2,realtime rt1,rt2,string s1,s2,int data);
    //bit clk, a, b, c; 
    //real r1=1.03, r2=1.03;
    //shortreal sr1, sr2;
    //int data; 
    //realtime rt1=101.11, rt2; 
    //string s1="TEST", s2="TEST"; 
       byte q1[$], y1=3, y2;
//    sequence q_test(byte q[$]);
//        byte v_q[$];
//        ($rose(a), v_q.push_back(y1)) ##1 q[0]==v_q.pop_front();
//    endsequence
//    ap_q: assert property(q_test(q1));

      sequence q_r(real ra, rb, realtime rt);
        ra==rb ##1 rt > rt1; 
    endsequence
//    ap_q_r: assert property(q_r(r1, r2, rt2));
//    always @ (posedge clk) rt2<= $realtime;
//    ap_test: assert property(s1==s2);

    sequence q_non_local_formal_arguments(int i=0, bit j); 
        i>10 ##1 j; 
    endsequence

    sequence q_local_formal_arguments(local input int i=0, untyped j,  
            local output bit t); 
        (i>10, j=i) ##1 (j==data, t=1'b1); 
    endsequence 
    property p_1;
        bit k; 
        int m, n;  
        (a, m=11, n=12) ##1 q_local_formal_arguments(m, n, k); 
    endproperty
   // ap_1: assert property(p_1); 

    sequence q_local_formal_arguments2(local input int i=0,  untyped j, k,   
            local output bit t); 
        (i>10, j=i) ##1 (1, j=data, t=1'b1) ##1 k; 
    endsequence 
    property p_test_untype;
        int x, z; 
        bit r; 
        (a, x=10) ##1 q_local_formal_arguments2(.i(x), .j(z), .k(a), .t(r)) ##1 
        x==z ##0 r; 
    endproperty : p_test_untype
   // ap_test_untype: assert property(p_test_untype);
endmodule : type_m
