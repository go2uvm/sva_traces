//
module top1;
   logic clk,rst;
logic a;

    default clocking cb_clk @ (posedge clk);  
    endclocking 
    initial forever #10 clk=!clk;
    m dut (.*);      
    initial begin
        @ (posedge clk) a <= 1'b1; 
    end

endmodule :top1
