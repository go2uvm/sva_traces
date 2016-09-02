module coverx(
    input  clk, smpl,
    output logic [7:0] a=8'b00000001);
  //  initial forever #10 clk=!clk;

    always @ (posedge clk) begin : FSM_emulation
        repeat(1) @ (posedge clk);
        a <= (a << 2);
        // t_cg.sample();
        @ (posedge clk);
        a <= (a << 1);
        @ (posedge clk);
        // a <= (a << 1);
    end : FSM_emulation

    always @ (posedge clk) a_cg1.sample();

    cp_a: cover property(@ (posedge clk iff smpl) $isunknown(a));


    covergroup a_cg;
        type_option.merge_instances = 0;
        option.per_instance = 1;
        option.get_inst_coverage = 1;
        a_cp : coverpoint a
        { bins a0 = {0};
            bins a1 = {1};
            bins a2 = {2};
            bins a4 = {4};
            bins a8 = {8};
            bins a16 = {16};
            bins a32 = {32};
            bins a64 = {64};
            bins a128 = {128};
        }
    endgroup : a_cg


    a_cg a_cg1 = new; // instantiation of covergroup
    
    generate for (genvar i=0; i<=7; i++)
        cp_ai: cover property(@ (posedge clk)a[i]); 
    
    endgenerate
endmodule : coverx
