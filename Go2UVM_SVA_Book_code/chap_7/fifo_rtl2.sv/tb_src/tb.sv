module tb;
  logic clk, reset_n, empty, full, almost_empty, almost_full; 
  logic [31:0]data_out, data_in;
  logic push, pop, error;

//Instantiate the DUT

fifo dut(.*);

  default clocking cb_blk @(posedge clk);
  endclocking : cb_blk

endmodule : tb

