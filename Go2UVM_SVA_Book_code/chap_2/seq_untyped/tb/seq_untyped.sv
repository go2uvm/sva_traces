module seq_untyped1;

    bit clk, a, b=1, c, d, e, f=1; 
    bit[7:0] a8=0, d8=8'hff; 
    int i, j; 

seq_untyped dut (.*);

    initial forever #10 clk=!clk; 
    default clocking cb_clk @ (posedge clk);
    endclocking 
   
    initial begin
        @ (posedge clk) ;
        @ (posedge clk);
        a8 <= 8'h22; 
        d8 <= 8'h22; 
        repeat (5) begin
            @ (posedge clk);
            @ (posedge clk);
            a8 <= ~a8; 
        end
    end


    int z=3, k=2;
    // Illegal: z and k are not elaboration-time constants
    // a2_illegal: assert property (@(posedge clk) q_delay(e, f, z, $, k));
endmodule : seq_untyped1

//For example, a reference to an untyped formal argument may appear in the specification of a
//cycle_delay_range, a boolean_abbrev, or a sequence_abbrev (see 16.9.2), only if the actual argument is an
//elaboration-time constant. The following example illustrates such usage of formal arguments:


