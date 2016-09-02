// temporal bining: concept proof (idea)

module bining(input clk,c_miss,mm_rd,input int c_a,m_a);



       // -------------------- original cover problem --------------------------
    property l2_cache(N,M);
        int v_a;
        @(posedge clk) (c_miss, v_a = c_a) |-> (##[N:M] mm_rd && m_a==v_a);
    endproperty                                                           
    cp_l2_cache: cover property (l2_cache(2,10));  


    // --------------------- cover with temporal bining ---------------------
    // ---- temporal bining coverage stuff ------
    bit[3:0] l2_cache_miss_delay;        
    covergroup temp_cg;
        type_option.merge_instances = 0;
        option.per_instance = 1;
        option.get_inst_coverage = 1;
        coverpoint l2_cache_miss_delay;
//        {
//            bins a0_2   = { [0 : 2] };  
//            bins a3_8 = { [3 : 8] };
//            bins a1[] = default;
//        }     
    endgroup
    temp_cg t_cg = new;

    function void temp_bin_sample(int M);    
        l2_cache_miss_delay = M;
        t_cg.sample();  
    endfunction

    // ---- LTL primitive for range-shift temporal bining ------
    sequence event_after_range_shift_bin_sample(N,M,e);
        int m_delay = 0;           
        @(posedge clk) ##N (!(e) , ++m_delay)   [*0:M-N] 
            ##1 (e , temp_bin_sample(N+m_delay) );  
    endsequence

    // -------------------- cover problem with temporal bining applied -----
    property l2_cache_bin_sample(N,M);
        int v_a;
        @(posedge clk) (c_miss, v_a = c_a) 
            |-> 
            event_after_range_shift_bin_sample(N,M,(mm_rd && m_a==v_a)) ;
    endproperty                                                           

    cp_cache: cover property (l2_cache_bin_sample(2,10));       

    // --------------------- testbench -------------------------------------
        endmodule



