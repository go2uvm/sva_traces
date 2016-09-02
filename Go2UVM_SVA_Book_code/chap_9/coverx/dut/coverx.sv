module coverx(input clk,smpl,input [3:0] a=4'b1XZ0);

    //bit clk, smpl;
    //logic[3:0] a=4'b1XZ0;
   reg temp,temp2;
    always @ (posedge clk)  begin : aly 
        temp <= 1'b1; 
	assign temp=smpl;
        t_cg.sample();
        @ (posedge clk);
        temp <= 1'b0; 
       temp2=4'b0010; 
	assign temp2=a;
    end  : aly

    // If cp_a coverage is ture, then an X or a Z was observed
    cp_aXZ: cover property(@ (posedge clk iff smpl) $isunknown(a)); 
    ap_aNoXZ: assert property(@ (posedge clk iff smpl) $isunknown(a)==0); 

    function automatic int countbits(logic[3:0]  v);
        automatic int s=0;
        for (int i=0; i<= 3; i++) begin 
            if (v[i]===1'bX || v[i]===1'bZ) begin
                s=s+1;
                $display("is X or Z"); 
            end
        end
        $display("%t v=%b, countbits=%d", $time, v, s);
        return s; 
    endfunction : countbits

    covergroup a_is_x_cg;
        type_option.merge_instances = 0;
        option.per_instance = 1;
        option.get_inst_coverage = 1;
        cp_unknown: coverpoint $isunknown(a)==0; 
        // ($isunknown ==0) i.e. true then no X or Z 
        cp_with_countbits:  coverpoint countbits(a) ==0 ; 
        // coverpoint $countbits (a, 'x, 'z) ==0; // 1800-2012 
        // ($countbits (a, 'x, 'z) ==0) then no X or Z 
    endgroup
    a_is_x_cg t_cg = new; // instantiation of covergroup

endmodule : coverx
