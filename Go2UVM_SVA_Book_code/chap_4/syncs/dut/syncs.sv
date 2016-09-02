module syncs(input clk,a=1,b=1,c,d=1,g,output e,f,h,enb);
   reg e,f,h,enb;
sequence q_1;
    @ (posedge clk) a ##2 b; 
endsequence : q_1
    sequence q_rdy;
        @ (posedge clk) d; 
    endsequence : q_rdy

    initial begin
        @ q_1  e <= !e; 
        @(posedge clk);

        @ q_rdy f <= !f; 
        repeat(5) @ (posedge clk);
        wait(q_1.triggered); 
        @(posedge clk);
 enb=1; 
    end

    always_ff @ (posedge clk iff enb)  begin : aly 
        h <= 1; 
    end  : aly

endmodule : syncs
