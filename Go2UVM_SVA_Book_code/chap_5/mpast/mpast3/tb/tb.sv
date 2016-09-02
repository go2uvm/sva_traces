
module top_illegal1; // should not compile
logic clk;    

top_illegal dut(.*);    


 default clocking cb_clk @ (posedge clk);  endclocking 


endmodule : top_illegal1
