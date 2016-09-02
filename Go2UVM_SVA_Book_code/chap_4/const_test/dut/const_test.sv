module const_test(input clk,input [3:0] a=4'b1011);
    //bit clk;
   // bit[3:0] a=4'b1011; // , b, c; 
       always_ff @ (posedge clk)  begin : aly 
        static int j=2; 
        for ( j=0; j<4; j++) begin
            // j is a static variable.  
            // Assertions uses the "sampled value" of the static variable  j, 
            // which is equal to 2 in the Preponed region. 
            // The action block uses the value of j in the Reactive region, which is 4  
            $display("at time %t loop static j=%d", $time, j); 
            static_j: assert property (a[j]) // same as a[$sampled(j)] 
                $display("static_j: action block: j=%d, a[$sampled(j)]=%d", j, a[$sampled(j)]); 
                  else $display("static_j: error action block: $sampled(j)=%d, a[$sampled(j)]=%d", 
                                      $sampled(j), a[$sampled(j)]);   

            // The sampled value of a const cast expression is defined as the current
            // value of its argument. Thus, the sampled value of const'(j) is the
            // current value of j.            
            apj_const: assert property (a[ (j)]) // uses current value for j in tha assertion
                $display("static_const:const'(j)=%d, a[const'(j)=%d",(j), a[(j)]);//error: undeclared type const
                   else
                $display("static_const: error const'(j)=%d, a[const'(j)=%d", (j), a[(j)]);
        end

        for (int i=0; i<4; i++) begin  // i is automatic 
        // Sampled values of automatic variables, local variables, and active free
        // checker variables (see Section XX) are their current values. However,
            $display("at time %t loop auto i=%d", $time, i); 
            auto_i: assert property (a[i]) 
                $display("auto_i: const'(i)= %d, a[const'(i)]=%d", (i), a[(i)]);
                else $display("auto_i: error const'(i)=%d  a[const'(i)]=%d", (i), a[(i)]); 
        end
    end  : aly

    initial $display("at startup time %t, aly.j=%d", $time, aly.j); 
endmodule : const_test 

