module dis2(input rst_n,a,b,c,rst_n_dly,clk,r,output c_ff,rst_an );

reg temp1,temp2;

        always @(posedge clk) begin
        temp1 <= c; 
    end
    assign rst_n = r && temp1; 
    assign   rst_n_dly = rst_n; 
    ap_1: assert property(@ (posedge clk)
        disable iff ($sampled(!rst_n))
        a |-> ##3 b);

    ap_dis_sync: assert property(@ (posedge clk)
        disable iff ($fell(!rst_n, @(posedge clk)))
        a |-> ##3 b);



    ap_eq: assert property(@ (posedge clk)
        disable iff (!temp2)
        a |-> ##3 b);

    ap_eqv: assert property(@ (posedge clk)
        disable iff (!rst_n_dly)
        a |-> ##3 b);

    ap_sync: assert property(@ (posedge clk)
        sync_accept_on (!rst_n)
        a |-> ##3 b);



    function automatic bit reset();
        temp2 = 1'b0;
    endfunction : reset

    function automatic bit set();
        temp2 = 1'b1;
    endfunction : set
 
 assign c_ff=temp1;
 assign rst_an=temp2;

  /*  assert (rst_n)
       set();
     else reset(); */

    ap_2: assert property(@ (posedge clk)
        disable iff ((!rst_n))
        a |-> ##3 b);

  
endmodule : dis2



