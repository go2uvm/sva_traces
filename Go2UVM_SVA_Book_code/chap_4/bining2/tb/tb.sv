// temporal bining: concept proof (idea)

module temporal_bining_test1;

    logic clk;
    logic c_miss, mm_rd;
    int c_a, m_a;
temporal_bining_test dut(.*);
        // --------------------- testbench -------------------------------------
    const int TEST_NUM = 10;  
    int m, addr;

    initial
    begin
        c_miss = 0; mm_rd = 0;          
        #1; clk = 0;

        for (int i=0; i<TEST_NUM; ++i)
        begin                          
            m = $urandom_range(10,100);
            addr = $urandom();
            $display("%d c read addr=%0h delay=%0d",$time,addr,m
                     );

            c_miss = 1;     
            #1; clk = 1;    
            #1; clk = 0;
            c_miss = 0;

            for (int j=0; j<m; ++j)
            begin
                #1; clk = 1;
                #1; clk = 0;
            end         

              mm_rd = 1;
            #1; clk = 1;
            #1; clk = 0;
            mm_rd = 0;
            //#10;

        end
    end

endmodule



