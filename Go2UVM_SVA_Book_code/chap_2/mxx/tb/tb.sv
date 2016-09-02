module top1; 
    bit push, pop, clk; 
    int fifo_count, MAXCOUNT;
    mxx dut(.*);
default clocking cb_clk @ (posedge clk);  endclocking 
endmodule : top1 