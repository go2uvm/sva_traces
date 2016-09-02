module count_ctrl(
    output [31:0] control_reg,
    output [1:0] bad_bits,
    input clk, init_done); 
 //  reg bad_bits;
 reg [1:0] temp;
    always begin
        wait(init_done); 
        temp[0] = 'x;
        temp[1] = 'z; 
    end
    assign bad_bits=temp; 
// X and Z allowed during initialization, but no Z or X allowed afterwards
    ap_control_reg: assert property(@(posedge clk)
    $countbits(control_reg, bad_bits[0], bad_bits[1]) == 0);
endmodule : count_ctrl
