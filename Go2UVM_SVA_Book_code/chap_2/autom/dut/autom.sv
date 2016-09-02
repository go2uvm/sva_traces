module autom (input clk,a,b,rd,input[31:0] wdata, foo=32'hFFFFFFFA, bar=32'hFFFFFFFB,int m,n,w );
   
      always @(posedge clk) begin : alw_foo
        automatic logic k=1'b0;  // automatic 
        static logic m=1'b1; // implicitly static 
        // k <= !k;  // non-blocking assignment may not be an automatic variable
        k = !k; // OK 
        // variable declared in for statement is automatic 
        for (int i=0; i<10; i++) begin
            a4: assert property (foo[i] && bar[i]);
        end
        //ap_k: assert property(k);
    end : alw_foo

    // Hierarchical access to item k in automatic block (alw_foo) not allowed
    // ap_illegalfoo: assert property(alw_foo.k);
    //ap_legalfoo: assert property(alw_foo.m);

    function automatic logic invert_auto(int a);
        return !a; 
    endfunction : invert_auto

    function logic invert_static(int a);
     //   w=a; 
        return !a; 
    endfunction : invert_static

  //  ap_function_legal: assert property(invert_auto(m)==n);
 //   ap_function_illegal: assert property(invert_static(m)==n);
endmodule : autom
