module top1;
    bit clk, clk2, a=1; 
    int unsigned k=16'hF0F0, m;
default_ag2 dut(.*); 
    initial forever #10 clk=!clk; 
    default clocking cb_clk @ (posedge clk);
    endclocking 
    endmodule : top1
//
