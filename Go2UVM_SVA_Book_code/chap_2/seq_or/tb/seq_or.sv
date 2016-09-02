module seq_or1;
bit clk, a=1'b1, c=1'b1; 
  int b=1, d=2, e=1;
 seq_or dut (.*);

        initial forever #10 clk=!clk; 
  
    default clocking cb_clk @ (posedge clk);
    endclocking
 
    endmodule : seq_or1
