//
module top1;
    `define true 1'b1
    bit clk,clk2, a=0,   b=0, c=1, d=1, e=1, w;
    int data, data1, data2, x, y;

   or_multi dut (.*);
    default clocking cb_clk @ (posedge clk);  
    endclocking 
    initial forever #10 clk=!clk;
    

    initial begin
        a <= 1'b0;
        b <= 1'b0; 
        repeat(2) @ (posedge clk);
        @ (posedge clk); 
        a <= 1'b0; 
        b <= 1'b1; 
        @ (posedge clk); 
        a <= 1'b1; 
        b <= 1'b0; 
        @ (posedge clk); 
        a <= 1'b1;
        b <= 1'b1; 
        repeat(2) @ (posedge clk);  
        $display("EOT"); 
    end

endmodule : top1
