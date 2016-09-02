module top1;
    bit clk, req, ack, done, crc_pass, crc_err, busy=1, ready=0, reset, x, a=0,  
    b0, b, c, d, x1=1, x0=0;
    bit a1=1, a2=1, a0, a4, a5, reset_n; 
    int i=4, j=8; 


 simple dut(.*);
    default clocking cb_clk @ (posedge clk);
    endclocking

   // default disable iff  (reset);
    initial forever #10 clk=!clk;

   



endmodule : top1
