
module types_static1;
    logic  clk; 
    int i; 
   
types_static dut(.*);
    default clocking cb_clk @ (posedge clk); endclocking 
       initial forever #10 clk=!clk; 
   
endmodule : types_static1

