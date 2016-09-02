module t(input a,b,c,clk10,clk13);
    // bit clk10, clk13, a, b, c; 
    // initial forever #10 clk10=!clk10;
    //initial forever #13 clk13=!clk13; 
    ap_ab10: assert property(@ (posedge clk10) !a |=> b); 
   ap_ab13: assert property(@(posedge clk13)!a |=> b); 
    m_sub sub1(clk2,
                  x,
                  y); 


endmodule : t 

module m_sub(input clk2,x=1,y,z);
     //bit clk2, x=1, y, z; 
   //default clocking cb_clk @ (posedge clk);  endclocking 
   ap_xy: assert property(@(posedge clk2)x |=> y);

endmodule : m_sub;
