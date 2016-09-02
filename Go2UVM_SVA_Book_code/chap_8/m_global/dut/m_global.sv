module m_global(input clk,clk13,a,b,c);
    
  //  initial forever #10 clk=!clk;
  //  initial forever #13 clk13=!clk13; 
   // clocking clk_global @(posedge clk); endclocking
   // default clocking cb_clk13 @ (posedge clk13);  endclocking 
    ap_ab10: assert property(@ ($default_clock) !a |=> b); 
    ap_ab13: assert property(@(posedge clk)!a |=> b); 
    m_sub sub1(); 


endmodule : m_global
module m_sub;
    bit clk2, x=1, y, z; 
    default clocking cb_clk @ ($default_clock);  endclocking 
    ap_xy: assert property(x |=> y);

endmodule : m_sub
