module m4251;
    logic x, y, clk, enb, enb0, enb1, a1, b1, c1, d1, e1, f1; 
    logic en, en1, a, b, c, reset_n, d, e, f,enb_local,ev;
m425 dut(.*);
    assign en1= a && b; 
        initial forever #10 clk=!clk; 

   
    initial begin
        repeat (3) @ (posedge clk);  
        a1=1'b1; 
        e1 <= 1'b0; 
        @ (posedge clk) a1 <=1'b0; 
    end   

       initial begin
        @ (posedge clk) 
            a <= 1'b1; 
        b <= 1'b0; 
      
        @ (posedge clk) b <= 1'b1;
                a <= 1'b0; 
    end
endmodule : m4251   

