
// "Re: Getting "wall clock" time in Systemverilog".
//  Getting "wall clock" time in Systemverilog | Verification Academy http://bit.ly/wRLgvD
// The quickest way is to use Verilog's $system() function, but that only prints to stdout.
// If you are using Questa and want to get the output into a string, 
// you can use the built-in DPI routine mti_fli::mti_Cmd("Tcl_command") and get a string result 
// with Tcl_GetStringResult(interp). 
// You can see an example in the Questa release tree /<install_dir>/examples/systemverilog/dpi/cpackages.

//If you want a vendor neutral method, you will have to write your own DPI C routine that calls a C system function.
//The comments in the following examples describe the conditions for the properties to be evaluated to true:
// if the clock ticks once more, then a shall be true at the next clock tick

module system_time1;
logic clk,a;
system_time dut(.*);

default clocking @(posedge clk); endclocking

endmodule : system_time1
