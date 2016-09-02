module test_funct(input clk, a, b, req_data,output flag);     
    reg temp;
    
    function automatic bit ab(); 
        return a && b; 
    endfunction : ab 

    function bit ab_illegal(bit w); // no "automatic" 
        temp <=w;    // side efffect 
        return a && b; 
    endfunction : ab_illegal  
assign flag=temp;
    sequence q_legal;
        logic v;
        ($rose(req_data),  v=ab()); 
    endsequence : q_legal

    sequence q_illegal;
        logic v;
        ($rose(req_data),  v=ab_illegal(1'b1)); 
    endsequence : q_illegal

    ap_test: assert property(@(posedge clk)$rose(a) |-> q_legal);
   endmodule : test_funct
