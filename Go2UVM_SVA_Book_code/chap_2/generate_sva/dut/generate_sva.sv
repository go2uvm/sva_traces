module test_print(input clk,input[7:0]a,b);

       property P(i, j); 
        @ (posedge clk) a[i] |=> b[j]; 
    endproperty : P
    generate
        begin : array_of_sva
            genvar i, j;
            for (i = 0; i<=7; i++) begin
                for (j = 0; j<=7; j++) begin
                    a1: assert property (P(i,j)); 
                end
            end
        end
    endgenerate
    
    endmodule : test_print
