module always_usage(
    input clk=1'b0, a, b, d,f, k,z ,output c,e,m,q); 
      reg temp1;
      reg temp2;
      reg temp3;
      reg temp4;
        
    always @(posedge clk)
    begin
        logic temp; 
        temp=a && b; // local evaluation, for later usage 
        if(temp) temp1 <= d; 
    end
   assign c=temp1;

    
    always_ff @(posedge clk) begin
        logic temp; 
        
        temp=a && b; // local evaluation, for later usage 
        if(temp) temp2 <= d; 
    end
    assign e=temp2;
    always_comb begin

        temp3=a || d;
    end
    assign m=temp3;
    always_latch if(k) temp4 <= z;;
    assign q=temp4;
endmodule
