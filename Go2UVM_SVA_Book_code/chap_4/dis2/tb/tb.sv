module top1;
    logic clk, r, rst_n, a, b, c, c_ff, rst_an, rst_n_dly; 
    initial forever #10 clk=!clk; 
    dis2 dut (.*);
 always @(posedge clk) begin 
        
        if(!randomize(rst_n, r, c))  $error("randomization failure"); 
    end

 default clocking @(posedge clk);
endclocking   
 
endmodule : top1



