module top1();
    bit clk, gx_start, data_last;
    int size=3; 
    typedef enum {READ, WRITE } rd_wr_e;
    rd_wr_e cmd; 
    initial forever #10 clk=!clk; 
   default clocking cb_clk @ (posedge clk);  endclocking 
   // Int v_start, size;  // why 32 bit int versus reg [2:0]


v9_8 dut (.*);

    always begin
        static int i=0; 
        @ (posedge clk) if(!randomize(cmd, gx_start, data_last))  
            $display("randomization failure");  
        i++; 
//        if(i> 10) data_last <=1'b0;     
    end
endmodule : top1
