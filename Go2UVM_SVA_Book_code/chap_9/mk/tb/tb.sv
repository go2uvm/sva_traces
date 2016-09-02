module top1;
    bit clk,clk0, clk2, a0, a1, b, c, d; 
   default clocking cb @(posedge clk);
endclocking
 mk dut (.*);
 
endmodule : top1
