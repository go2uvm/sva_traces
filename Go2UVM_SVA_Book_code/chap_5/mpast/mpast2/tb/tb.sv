
//6.21 Scope and lifetime
module top_legal1;
logic clk;
    int svar1; // static keyword optional
top_legal dut(.*);    


 default clocking cb_clk @ (posedge clk);  endclocking 

endmodule : top_legal1

