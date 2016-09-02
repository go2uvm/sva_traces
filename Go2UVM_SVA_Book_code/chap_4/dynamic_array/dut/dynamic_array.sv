module dynamic_array(input clk);
    
   int dyn[],d2[];
int a_size,d2_value;
    always_comb 
       if (d2.size>0 && d2.size <= 5  ) d2_value = d2[5]; 
    initial begin
        dyn = new[5]; // Allocate 5 elements
        $display("dyn.size=%d", dyn.size);
        foreach (dyn[j])
            dyn[j] = j; // Initialize the elements
        d2 = dyn; // Copy a dynamic array
        d2[0] = 5; // Modify the copy
        $display(dyn[0],d2[0]); // See both values (0 & 5)
        
        dyn = new[20](dyn); // Expand and copy
        $display("dyn.size=%d, d2.size=%d", dyn.size, d2.size);
        dyn = new[100]; // Allocate 100 new integers
        $display("dyn.size=%d, d2.size=%d", dyn.size, d2.size);
        repeat(20) @ (posedge clk); 
        // Old values are lost
        dyn.delete; // Delete all elements
        $display("dyn.size=%d, d2.size=%d", dyn.size, d2.size);
    end
    
    always_ff @ (posedge clk)  begin : aly 
        // Illegal reference to dynamic array "d2".
         //ap_dy_array: assert property(@(posedge clk)d2.size > 0 |-> d2[0]==5);
        ap_dy_array: assert property(@(posedge clk)a_size > 0 |-> d2_value); // d2[0]==5);
    end  : aly

endmodule :dynamic_array
//run 1 ns
//# dyn.size=          5
//#           0          5
//# dyn.size=         20, d2.size=          5
//# dyn.size=        100, d2.size=          5
//# dyn.size=          0, d2.size=          5

