module assert_cntrl1;
    logic a, b, c,  w, clk, d; 
    logic[3:0] v=4'b1010; 
    
assert_cntrl1 dut (.*);

initial begin
 repeat (10) 
        #10  if(!randomize(a, b, v))  $error("randomization failure"); 
    end


endmodule : assert_cntrl1
