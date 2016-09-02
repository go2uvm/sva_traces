module top1;
    bit clk;
    bit [7:0] a, b; 
    initial forever #10 clk=!clk; 
    test_print dut(.*);
  default clocking cb @(posedge clk);
 endclocking
    initial begin  
        for (int i=0; i<5; i++) begin
            $display($sformatf("test%0d", i)); 
        end
        a = 'b1; // 8'hF1;
    end 
endmodule : top1
