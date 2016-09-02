module seq_and1;
    bit clk, a=1'b1, b=1'b1, c=1'b1, d=1'b1, w, r, x, y, e; 
    int data, data1, data2; 
    initial forever #10 clk=!clk; 

   seq_and dut(.*);
    default clocking cb_clk @ (posedge clk);
    endclocking
    `define true 1'b1 
   
    

endmodule : seq_and1
