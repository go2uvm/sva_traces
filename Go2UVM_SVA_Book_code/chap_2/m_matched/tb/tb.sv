module top1;

    bit clk, clk1, a=0,  b0, b, c, d, e;

 m_matched dut(.*);
    default clocking cb_clk @ (posedge clk);  endclocking 
    initial forever #10 clk=!clk; 
    initial forever #10 clk1=!clk1; 
    

endmodule : top1
