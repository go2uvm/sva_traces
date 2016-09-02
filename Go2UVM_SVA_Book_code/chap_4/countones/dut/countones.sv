module countones(input [31:0] control_reg,input [1:0] bad_bits ,input clk, init_done );
   //logic [31:0] control_reg;
    //logic [1:0] bad_bits;
    //logic clk, init_done; 
  // X and Z allowed during initialization, but no Z or X allowed afterwards
    ap_control_reg: assert property(@(posedge clk)
        $countbits(control_reg, bad_bits[0], bad_bits[1]) == 0);
endmodule : countones
