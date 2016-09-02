module m_eventually21;
    logic clk, req, ack, done; 
    default clocking cb_clk @ (posedge clk); endclocking 
       initial forever #10 clk=!clk; 
    
    initial  begin
        @ (posedge clk) req <= 1'b1; 
        repeat (4) @ (posedge clk); 
        ack <= 1'b1; 
        repeat(2) 
        @ (posedge clk); 
        done <= 1'b1; 
        @ (posedge clk); 
        $display ("end of sim"); 
    end
endmodule : m_eventually21
