module count_ctrl1;
    logic [31:0] control_reg;
    logic [1:0] bad_bits;
    logic clk, init_done; 
	
	count_ctrl dut (.*);
    endmodule : count_ctrl1
