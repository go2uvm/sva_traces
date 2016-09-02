module seq_trig1;
    bit clk, a, b, c, d, w, r, x, y, e; 
    bit write, read, parity_error; 
    int data, data1, data2, address;
`define true 1'b1 

 seq_trig dut(.*);  
    initial forever #10 clk=!clk;


    default clocking cb_clk @ (posedge clk);
    endclocking
    
endmodule : seq_trig1
