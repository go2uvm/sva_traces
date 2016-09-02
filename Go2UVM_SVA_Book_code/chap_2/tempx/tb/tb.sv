module top1;
    bit clk, req_data, d, ready, data, done, q, req, ack; 
    bit a; 
    int max_count;
   tempx dut (.*);
default clocking @(negedge clk); endclocking

endmodule : top1
