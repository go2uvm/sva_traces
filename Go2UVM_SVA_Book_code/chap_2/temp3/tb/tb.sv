module temp31;
    logic clk, clk1, clk2, req, ack, done, crc_pass, crc_err, busy, ready,l_b, 
    req_data, reset, x, a,  b0, b, c, d, e, fx1, x0;
    logic  bus_select, bus1, req1, ack1, req2, ack2;
            logic flag;
temp3 dut(.*);
 initial forever #10 clk=!clk; 

    default clocking cb_clk @ (posedge clk);  endclocking 
       

endmodule


