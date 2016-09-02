module top2;
  timeunit 1ns;
int dyn[], d2[]; // Empty dynamic arrays
 int a_size, d2_value; 
 bit clk;  
initial forever #10 clk=!clk; 
 
     

 dynamic_array dut(.*);

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

  
    
endmodule : top2

