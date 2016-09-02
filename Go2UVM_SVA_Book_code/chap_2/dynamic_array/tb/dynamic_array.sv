module dynamic_array1;
    int dyn[], d2[]; // Empty dynamic arrays
    int a_size, d2_value; 
   logic clk; 
dynamic_array dut(.*);
    initial forever #10 clk=!clk; 
   
endmodule :dynamic_array1
//run 1 ns
//# dyn.size=          5
//#           0          5
//# dyn.size=         20, d2.size=          5
//# dyn.size=        100, d2.size=          5
//# dyn.size=          0, d2.size=          5

