//// Maybe you need to show an example of what the design looks like without the bind. I don't understand why you want to instantiate the module fifo_assertions inside the top level testbench. I thought you only wanted to instantiate the fifo_assertions inside the module FIFO. Also, once you have started using SystemVerilog, there is no longer a distinction between Verilog and SystemVerilog modules; it's all one language. The bind construct can target any module regardless of whether it was originally coded for Verilog, and regardless of where in the hierarchy it is.
//
////				So if your FIFO is
//
//module FIFO(ports);
//	reg Full;
//	reg Empty;
//endmodule
//// and it is instantiated throughout your design
//
//module sub_component(ports);
//	FIFO u23(ports);
//endmodule
//module sub_sub_component(ports);
//	FIFO u34(ports);
//endmodule
////The using the bind command below will instantiate the fifo_assertions module in every FIFO instance.
//
//bind FIFO fifo_assertions fa_1(Full,Empty);
//The bind construct effectively modifies the FIFO module as if you had written it as
//
//		module FIFO(ports);
//	reg Full;
//	reg Empty;
//	fifo_assertions fa_1(Full,Empty);
//endmodule
////Now when ever a FIFO is instantiated, another fifo_assertions module is instantiated underneath it.



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
	logic clk, reset, request, ack,done;
	 logic[7:0] data_in;
	 logic[7:0] data_out;
	
	// signals local to testbench 
	// perform 2 instantiations of test_rtl, using 2 styles 
	rtl rtl_1(clk, reset, request, ack, done);
	rtl rtl_2(.*);
  
	bind rtl      // design under test
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
