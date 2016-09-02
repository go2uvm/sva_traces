// temporal bining: concept proof (idea)

module top1;

    bit clk;
    bit c_miss, mm_rd;
    int c_a, m_a;
     // Cache address, memory address
    // -------------------- original cover problem --------------------------
        initial forever #10 clk=!clk; 

bining dut(.*);
     
    initial   begin
    int TEST_NUM;
    int addr,m; 

        c_miss = 0; mm_rd = 0;          
        #1; clk = 0;

        for (int i=0; i<TEST_NUM; ++i) begin  
            @ (posedge clk);                        
            m = $urandom_range(2,10);
            addr = $urandom();
            $display("%d c read addr=%0h delay=%0d",$time,addr,m);
            c_a = addr;
            c_miss = 1;     
            @ (posedge clk) c_miss <= 0;
            repeat (m) @ (posedge clk); 
            m_a = addr;
            mm_rd = 1;
            @ (posedge clk);
            mm_rd = 0;
        end
    end

endmodule:top1


