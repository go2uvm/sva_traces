module top2;
  timeunit 1ns;
  timeprecision 1ns;
  bit clk, a, b, c, d; 

 initial forever #10 clk=!clk; 
 default clocking cb_clk @ (posedge clk);  endclocking 
     

cover_seq dut (.*);
  
   initial begin
        repeat (10) begin
            @ (posedge clk) 
                a <= 1'b1; 
            @ (posedge clk); 
            a <= 1'b0; 
            b <= 1'b1; 
            @ (posedge clk);
            b <= 1'b0; 
        end

end 
     
endmodule : top2

