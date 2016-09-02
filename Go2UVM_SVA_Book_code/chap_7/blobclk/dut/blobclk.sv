module t(
    input clk10, clk13, a, b, c); 
    //initial forever #10 clk10=!clk10;
    //initial forever #13 clk13=!clk13; 
    //global clocking clk_global @(posedge clk10); endclocking
    //default clocking cb_clk13 @ (posedge clk13);  endclocking 
    ap_ab10: assert property(@ (posedge clk10) !a |=> b); 
    ap_ab13: assert property(@(posedge clk13)!a |=> b); 
    m_sub sub1(); 


endmodule : t 

module m_sub(
    input clk2, x=1, y, z); 
   // default clocking cb_clk @ ($global_clock);  endclocking 
    ap_xy: assert property(@(posedge clk2)x |=> y);

endmodule : m_sub;
