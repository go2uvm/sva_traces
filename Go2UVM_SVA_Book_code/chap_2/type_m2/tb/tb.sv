module type_m1;
    bit clk, a, b, c; 
    real r1=1.03, r2=1.03;
    shortreal sr1, sr2;
   int data; 
    realtime rt1=101.11, rt2; 
    string s1="TEST", s2="TEST"; 
 type_m dut(.*);
    default clocking cb_clk @ (posedge clk);
    endclocking 

    initial forever #10 clk=!clk; 
 endmodule : type_m1
