//
module or_multi(input clk,clk2,a=0,b=0,c=1,d=1,e=1,w,input int data,data1,data2,x,y);
    `define true 1'b1
    
  
    sequence q_ab(local input bit lv);  
        (a==lv, lv=!lv)  ##1 !b;
    endsequence : q_ab 
    sequence q_cd(local input bit lv);  
        (c==lv, lv=0) ##2 d; 
    endsequence : q_cd
    property p_abcd;
        bit v; 
        (a, v=1) or (b, v=0) |=> v;    
    endproperty : p_abcd

    property p_abcd_eqv;
        bit v1, v2; 
        ( (a, v1=1'b1) |=> v1) and 
        ( (b, v2=1'b0) |=> v2);
    endproperty : p_abcd_eqv

    ap_abcd: assert property(@(posedge clk)p_abcd);
    ap_abcd_eqv: assert property(@(posedge clk)p_abcd_eqv);

    ap_1: assert property(@(posedge clk)
        ($rose(a) ##[1:5] b) or 
        ($rose(a) ##[1:2] c)  |-> 1
        );
    ap_b: assert property(@(posedge clk)
        ($rose(a) ##[1:5] b) and 
        ($rose(a) ##[1:2] c) |-> 1
        );

    sequence q_no_flow_out;
        int v_x, v_y;
        ((a ##1 (b, v_x = data, v_y = data1) ##1 c) or  // Thread 1:  v_x and v_ y assigned
        (d ##1 (`true, v_x = data) ##0 (e==v_x)))         //  Thread 2:  v_x assigned,  
        //                   v_ y unassigned and uninitialized. 
        // Thus, v_x flows out, and  v_y does not flow out 
        ;// ##1 (v_y==data2);  // Local variable v_y referenced in expression where it does not flow.  
        // Illegal: v_y cannot be read in thread 2 because it was not uninitialized
        // in the thread or during the initialization of the local variable at declaration. 
    endsequence : q_no_flow_out

    sequence q_flow_out;
        int v_x, v_y;
        ((a ##1 (b, v_x = data, v_y = data1) ##1 c) or  // Thread 1:  v_x and v_ y assigned
        (d ##1 (`true, v_x = data, v_y=0) ##0 (e==v_x)))  // Thread 2:  v_x and v_ y assigned    
        ##1 (v_y==data2);   
    endsequence : q_flow_out

    sequence q_flow(v);   //v is blocked from flowing out 
        ( 
        ((a, v=x) ##1 b) intersect 
        (c ##1 (d, v=y))  
        )  
        ; 
    endsequence : q_flow

    property p_no_out_flow;  
        int v;   
        ( 
        ((a, v=x) ##1 b) intersect 
        (c ##1 (d, v=y))  
        )  
        ##1 v==1;  // ocal variable v referenced in expression where it does not flow.
    endproperty : p_no_out_flow

   // ap_p_no_out_flow: assert property(@(posedge clk)p_no_out_flow);  

    sequence q_illegal2;  // v_z is blocked from flowing out
        logic v_z; 
        // Local variable v_z referenced in expression where it does not flow.
        q_flow(v_z) ##1 (w ##1 v_z);  //   Local variable v_z referenced in expression where it does not flow.
    endsequence :q_illegal2 


    sequence s7;
        int x,y;
        ((a ##1 (b, x = data, y = data1) ##1 c)
        and (d ##1 (`true, x = data) ##0 (e==x))) ##1 (x==data2);
// illegal because x is common to both threads
//Local variable x referenced in expression where it does not flow. 
    endsequence
    sequence s8;
        int x,y;
        ((a ##1 (b, x = data, y = data1) ##1 c)
        and (d ##1 (`true, x = data) ##0 (e==x))) ##1 (y==data2);
// legal because y is in the difference
    endsequence
    property p_and_legal;
        int x,y;
        ((a ##1 (b, x = data, y = data1) ##1 c)  and
        (d ##1 (`true, x = data) ##0 (e==x))) ##1 (y==data2) 
       // |=> x==1; // Local variable x referenced in expression where it does not flow.
       |=> y==1; 
// legal because y is in the difference
    endproperty : p_and_legal
    ap_and_legal: assert property(@(posedge clk)p_and_legal);


    
endmodule : or_multi
