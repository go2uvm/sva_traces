module top1;
    logic clk, req, ack, done, transfer_envelope, parity_error;
    recursive dut(.*);
    default clocking cb_clk @ (posedge clk);
    endclocking 
           
endmodule : top1
