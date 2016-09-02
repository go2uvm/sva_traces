module m16_14(input clk,input [11:0]foo=12'hFFF,bar=12'hFFF);
       always @(posedge clk) begin
        int i = 10;
        for (i=0; i<10; i++) begin
            $display("i=%d, $sampled(i)= %d", i, $sampled(i)); 
            a1: assert property (foo[i] && bar[i]);
            a2: assert property (foo[i] && bar[i]);//const'
            a3: assert property (foo[i] && bar[i]);//const'
        end
    end
endmodule : m16_14
