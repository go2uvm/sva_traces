module top1;
    logic clk, bus_select, bus1,reset, req1, ack1, req2, ack2;
    
mux_bus dut(.*);

 default clocking cb_clk @ (clk);
    endclocking 
    
endmodule : top1
