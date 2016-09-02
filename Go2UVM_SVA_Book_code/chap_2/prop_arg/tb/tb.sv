module top1;
    bit clk, ready=1'b1, request=1'b1, acknowledge, done; 
    initial forever #10 clk=!clk; 
    prop_arg dut(.*);
    default clocking cb_clk @ (posedge clk);
    endclocking

   endmodule : top1
