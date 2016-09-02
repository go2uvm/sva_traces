logic [5:0] x, y; 

module cover_seq;
    bit clk, a, b, c, d; 
    initial forever #10 clk=!clk; 
    default clocking cb_clk @ (posedge clk);  endclocking 
    cq1: cover sequence(a ##[1:5] b); 

    initial begin
        @ (posedge clk) 
        a <= 1'b1; 
        x <= 6'b10100; 
        @ (posedge clk); 
        a <= 1'b0; 
        b <= 1'b1; 
        @ (posedge clk);
        b <= 1'b0; 

    end

endmodule : cover_seq

module jim;
    initial begin
        #50 $display("x at root= %h", x); 
    end

endmodule : jim

module top2(input [5:0]x,y,input clk);
    cover_seq cq1(); 
    jim j1(); 

endmodule : top2
