// temporal bining: concept proof (idea)

module temporal_bining_test(input clk, c_miss, mm_rd,input int c_a, m_a);


   
    // -------------------- original cover problem --------------------------
    property l2_cache(N,M);
        int v_a;
        @(posedge clk) (c_miss, v_a = c_a) |-> (##[N:M] mm_rd && m_a==v_a);
    endproperty                                                           

    cover property (l2_cache(10,100));  


    // --------------------- cover with temporal bining ---------------------

    // ---- temporal bining coverage stuff ------
    int l2_cache_miss_delay;        

    covergroup temp_cg;
        coverpoint l2_cache_miss_delay;     

    endgroup

    temp_cg t_cg = new;

    function void temp_bin_sample(int N, int M);    
        l2_cache_miss_delay = M;
        t_cg.sample();  
    endfunction

    // ---- LTL primitive for range-shift temporal bining ------
    sequence event_after_range_shift_bin_sample(N,M,e);
        int m_delay = 0;           
        @(posedge clk) ##N (!(e) , ++m_delay)   [*0:M-N] 
            ##1 (e , temp_bin_sample(N,N+m_delay) );  
    endsequence


    // -------------------- cover problem with temporal bining applied -----
    property l2_cache_bin_sample(N,M);
        int v_a;
        @(posedge clk) (c_miss, v_a = c_a) 
            |-> 
            event_after_range_shift_bin_sample(N,M,(mm_rd && m_a==v_a))
            ;
    endproperty                                                           

    cover property (l2_cache_bin_sample(10,100));       

    // --------------------- testbench -------------------------------------
   
endmodule



