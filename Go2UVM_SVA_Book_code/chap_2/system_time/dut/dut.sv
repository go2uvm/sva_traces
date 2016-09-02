
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

module system_time(input clk,a);
property p1;
    nexttime a;
endproperty
// the clock shall tick once more and a shall be true at the next clock tick.
property p2;
    s_nexttime a;
endproperty
// as long as the clock ticks, a shall be true at each future clock tick
// starting from the next clock tick
property p3;
    nexttime always a;
endproperty
// the clock shall tick at least once more and as long as it ticks, a shall
// be true at every clock tick starting from the next one
property p4;
    s_nexttime always a;
endproperty
// if the clock ticks at least once more, it shall tick enough times for a to
// be true at some point in the future starting from the next clock tick
property p5;
    nexttime s_eventually a;
endproperty
// a shall be true sometime in the strict future
property p6;
    s_nexttime s_eventually a;
endproperty
// if there are at least two more clock ticks, a shall be true at the second
// future clock tick
property p7;
    nexttime[2] a;
endproperty
// there shall be at least two more clock ticks, and a shall be true at the
// second future clock tick
property p8;
    s_nexttime[2] a;
endproperty

endmodule : system_time
