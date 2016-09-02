module assertion_err(input clk,reset_n,go,input int cntr); 
   ap_err: assert property(@ (posedge clk) go);
  endmodule : assertion_err 
// vlog -sv -O0 +acc=a assertion_err.sv
// vsim -novopt work.assertion_err  -voptargs=+acc -assertdebug
