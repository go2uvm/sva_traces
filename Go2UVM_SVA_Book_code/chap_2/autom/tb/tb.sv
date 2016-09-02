module autom1;
    bit clk, a, b, rd; 
    // automatic bit k, z; // illegal declaration 
    logic[31:0] wdata, foo, bar; // foo=32'hFFFFFFA, bar=32'FFFFFFB; 
    int m, n, w; 
autom dut(.*);
    initial forever #10 clk=!clk;
       default clocking cb_clk @ (posedge clk);
    endclocking 

    endmodule : autom1
