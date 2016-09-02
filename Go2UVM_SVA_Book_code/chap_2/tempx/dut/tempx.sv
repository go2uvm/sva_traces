module tempx(input clk, req_data, d, ready, data, done, q, req, ack, a, 
     input int max_count);

       property   p_req2send;  
        logic [15:0] v_data;
        first_match( ($rose(req_data), v_data =data)   
        ##[0:3] (ready && d==v_data, v_data=data)) |->  
        ##[0:5] done && q==v_data;    
    endproperty   : p_req2send 

    property   p_req2send2;  // Better style
        logic [15:0] v_data_t1, v_data_t2;  // use separate local variables 
        first_match( ($rose(req_data), v_data_t1 =data)   
        ##[0:3] (ready && d==v_data_t1, v_data_t2=data)) |-> 
        ##[0:5] done && q==v_data_t2;   
    endproperty   : p_req2send2 

   // initial max_count=10;
    property q_req_ack;  
        int v_count;  
        ($rose(req), v_count=0) |-> 
        (1'b1, v_count+= 1) [*0:$] ##1 v_count >= max_count || ack; 
    endproperty  : q_req_ack

    sequence q_test (
        local inout int lv_count);   
        (a, lv_count+= 1); // 
    endsequence : q_test 

    property p_test;
        int v_c;  //Uninitialized local variable v_c is getting passed to an input type formal.
        q_test(v_c);    
    endproperty : p_test

    property p_test_OK;
        int v_c; 
        (1, v_c=0) ##0 q_test(v_c);   // v_c is uninitialized, but value read in q_test   
    endproperty : p_test_OK


endmodule : tempx
