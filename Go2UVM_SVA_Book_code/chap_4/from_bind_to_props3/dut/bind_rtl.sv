// bind_rtl.sv  example 
module rtl (
	input logic clk, reset, request, ack, 
	input logic[7:0] data_in, 
	output logic[7:0] data_out);
	timeunit 1ns;   timeprecision 100ps;
	logic done;  // done is to test_rtl 
	// .. 
endmodule : rtl

module handshake_props (input logic clk, reset, request, ack, done);
	timeunit 1ns;   timeprecision 100ps;
	//..
	property p_req_ack (clk, a, b, c);
		@ (posedge clk) $rose(a) |-> ##[1:2] b ##1 c; 
	endproperty : p_req_ack
	
	ap_req_ack : assert property  (p_req_ack(clk, request, ack, done)) else 
		$display ("%m 1 Request-acknowledge failure");
endmodule : handshake_props

module test3_tb;
	timeunit 1ns;   timeprecision 100ps;
	logic clk, reset, request, ack; // signals local to testbench 
	// perform 2 instantiations of test_rtl, using 2 styles 
	rtl rtl_1(clk, reset, request, ack, done);
	rtl rtl_2(.*);
  
	bind test_rtl      // design under test
	handshake_props    // module/interface containing the properties
	handshake_props_1(.*); // instance of handshake_props that contains the properties.
	// Binding connection to clk, reset, request, ack of test_rtl ports , and to 
	//    done internal to test_rtl
	// handshake_props_1 gets bound to the module named test_rtl. 
	// Consequently, all instances of design_rtl will contain handshake_props_1.
//…
endmodule : test3_tb

// same as 
module rtl_same (
	input logic clk, reset, request, ack, 
	input logic[7:0] data_in, 
	output logic[7:0] data_out);
	timeunit 1ns;   timeprecision 100ps;
	logic done;  // done is to test_rtl 
	// .. 
	handshake_props handshake_props_1(.*); 
endmodule : rtl_same

