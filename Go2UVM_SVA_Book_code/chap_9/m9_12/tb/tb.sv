module m9_121;
    logic clk, req, grant, frame, time_out, aquired;
m9_12 dut(.*);
    initial forever #10 clk=!clk; 
    default clocking cb_clk @ (posedge clk);  endclocking 

       
    initial begin
        @ (posedge clk); 
        req<=1'b1; 
        @ (posedge clk); 
        grant <= 1'b1; 
        @ (posedge clk); 
        repeat(62) @ (posedge clk); 
        time_out <= 1'b1; 
        $display("end of init"); 
    end

endmodule : m9_121
