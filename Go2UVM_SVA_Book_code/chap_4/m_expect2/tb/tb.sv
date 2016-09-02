module top1;
 int pri_level;
 integer data;  
 
    logic clk, go, ready, t;
    logic [1:0]req, ack;
    initial forever #10 clk=!clk; 
 
 m_expect dut(.*);
 
       default clocking d_clk  @(posedge clk);  endclocking 
    initial begin
        @ (posedge clk) ready <= 1'b1; 
        @ (posedge clk) go <= 1'b1; 
        @ (posedge clk) req <= 2'b11;
        @ (posedge clk) ack[1] <= 1'b1; 
        ready <= 1'b0;
    end
 
    
endmodule : top1
//
