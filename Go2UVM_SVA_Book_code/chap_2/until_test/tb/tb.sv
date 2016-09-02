module until_test1;
    logic clk, req, busy, ready; 
    
   
     until_test dut(.*);   
 default clocking cb_clk @ (posedge clk);
   endclocking

endmodule : until_test1
