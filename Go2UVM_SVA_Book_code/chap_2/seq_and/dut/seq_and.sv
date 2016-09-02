module seq_and(input clk,a,b,c,d,w,r,x,y,e,input int data,data1,data2);
   
        `define true 1'b1 
    sequence q_no_out_flow(v);   //v is blocked from flowing out 
        ((a, v=x) ##1 b) intersect (c ##1 (d, v=y)); 
    endsequence : q_no_out_flow
    sequence q_illegal2;  // v_z is blocked from flowing out
        logic v_z; 
        // Local variable v_z referenced in expression where it does not flow.
        q_no_out_flow(v_z) ##1 (w ##1 v_z);    
    endsequence :q_illegal2

    sequence q_illegal_and;
        int  v_x, v_y;
        ((a ##1 (b, v_x = data, v_y = data1) ##1 c)       //  Thread 1, v_x and v_y assigned 
        and (d ##1 (`true, v_x = data) ##0 (e==v_x)))   // Thread 2, v_x assigned 
        ##1 (v_x==data2);   //   Illegal because v_x is common to both threads
        // When reading v_x in “##1 (v_x==data2)”,  The v_x from which thread to use?  
        // It cannot be determined.  
    endsequence : q_illegal_and

    sequence q_legal_and;
        int v_x, v_y;
        ((a ##1 (b, v_x = data, v_y = data1) ##1 c)  // Thread 1, v_x and v_y assigned
        and (d ##1 (`true, v_x = data) ##0 (e==v_x)))  // Thread 2, v_x assigned
        ##1 (v_y==data2);  //   legal because  v_y  is assigned in only one thread. 
    endsequence : q_legal_and

endmodule : seq_and
