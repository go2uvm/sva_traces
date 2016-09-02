module seq_event1;
    bit clk, clk2, a=0, b=0, c=1; 
    initial forever #10 clk=!clk; 
    initial forever #7 clk2 =!clk2;
   seq_event dut (.*); 
       initial begin 
        #12 a=1; b=1;
        #42 b=0; 
        #72 b=1;
    end 

   
endmodule : seq_event1
