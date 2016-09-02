module top1;     
    bit clk, a, b, req_data, flag;
    initial forever #10 clk=!clk;

 test_funct dut (.*);
    default clocking cb_clk @ (posedge clk);  endclocking 
        initial begin
        @ (posedge clk); 
        a <= 1'b1; 
        req_data <= 1'b1; 
    end
endmodule :top1
