module autovrab(input clk, a, b, c,output byte byt,byts);
    //bit clk, a, b, c;
 //   byte byt, byts; 
    
    always_ff @ (posedge clk) begin
        automatic byte v; // gets created and set to 0 at every entry 
        static byte s; 
        $display("v, s  before =%d %d", v, s);  
        v=v+1'b1; 
        s=s+1'b1;
        $display("v after=%d %d ", v, s); 
        byt<=v; 
        byts <= s; 
    end

endmodule : autovrab
