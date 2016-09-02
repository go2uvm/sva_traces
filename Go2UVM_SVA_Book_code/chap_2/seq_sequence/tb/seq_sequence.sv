module seq_sequence1;
    bit clk, clk2, a, b, c, d, e, f, a8, b8; 
    //bit[7:0] a8, d8; 
    int i, j;
seq_sequence dut (.*); 
    initial forever #10 clk=!clk; 
    initial forever #7 clk2=!clk2; 
    default clocking cb_clk @ (posedge clk);
    endclocking 
    
endmodule : seq_sequence1
