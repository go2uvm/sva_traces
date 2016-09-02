module top1;
    logic clk, clk1, clk2, req, ack, done, crc_pass, crc_err, busy=1, ready=0, 
    req_data, reset, x, a=0,  b0, b, c, d, e, fx1=1, x0=0;
    bit a1=1, a2=1, a0, a4, a5, reset_n, x1; 
    int i, j; 
    logic flag;
    int data;
     
    clk_event dut (.*);

   // initial forever #10 clk=!clk; 
    // default clocking cb_clk @ (posedge clk);  endclocking 
    
endmodule:top1
