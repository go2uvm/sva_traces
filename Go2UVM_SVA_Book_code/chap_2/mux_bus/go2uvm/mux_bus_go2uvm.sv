/********************************************
* VerifWorks Go2UVM App: VW_DVC_Go2UVM
* Automatically generated by VerifWorks's DVC_Go2UVM Riviera Apps 
* Thanks for using VerifWorks products
* Visit http://www.verifworks.com for more 
* Generated on   : 2016-05-28 14:16:39
********************************************/ 



// Generating SystemVerilog interface for module: mux_bus
// ---------------------------------------------------------
interface mux_bus_if (input logic clk);
  logic  [0:0] bus1;
  logic  [0:0] bus_select;
  logic  [0:0] rst_n;
  logic  [0:0] req1;
  logic  [0:0] req2;
  logic  [0:0] ack1;
  logic  [0:0] ack2;
  // End of interface signals 


  // Start of clocking block definition 
  clocking cb @(posedge clk);
    output bus1;
    output bus_select;
    output rst_n;
    output req1;
    output req2;
    input ack1;
    input ack2;
  endclocking : cb
  // End of clocking block definition 

endinterface : mux_bus_if
// Automatically generated from VerifWorks's DVCreate-Go2UVM product
// Thanks for using VerifWorks products, see http://www.verifworks.com for more

import uvm_pkg::*;
`include "uvm_macros.svh"
// Import Go2UVM Package
import vw_go2uvm_pkg::*;
// Use the base class provided by the vw_go2uvm_pkg
class mux_bus_test extends go2uvm_base_test;
  // Create a handle to the actual interface
  virtual mux_bus_if vif;
  task reset();
    `uvm_info (log_id, "Start of reset", UVM_MEDIUM)
   // `uvm_info (log_id, "Fill in your reset logic here ", UVM_MEDIUM)
     this.vif.cb.rst_n <= 1'b0;
     repeat (5) @ (this.vif.cb);
     this.vif.cb.rst_n <= 1'b1;
     repeat (1) @ (this.vif.cb);
    `uvm_info (log_id, "End of reset", UVM_MEDIUM)
  endtask : reset
  task main ();
    `uvm_info (log_id, "Start of main", UVM_MEDIUM)
    //`uvm_info (log_id, "Fill in your main logic here ", UVM_MEDIUM)
	
	@(vif.cb);
	  begin
		@(vif.cb);
			vif.cb.bus_select <= 1'b0;
			vif.cb.bus1 <= 1'b0;
			vif.cb.req1 <= 1'b0;
			vif.cb.req2 <= 1'b0;
		@(vif.cb);
			vif.cb.bus_select <= 1'b1;
			vif.cb.bus1 <= 1'b1;
			vif.cb.req1 <= 1'b1;
			vif.cb.req2 <= 1'b1;
		@(vif.cb);
		@(vif.cb);
		@(vif.cb);
		@(vif.cb);
		@(vif.cb);
		@(vif.cb);
			vif.cb.bus_select <= 1'b1;
			vif.cb.bus1 <= 1'b0;
			vif.cb.req1 <= 1'b1;
			vif.cb.req2 <= 1'b1;
		@(vif.cb);
			vif.cb.bus_select <= 1'b0;
			vif.cb.bus1 <= 1'b0;
			vif.cb.req1 <= 1'b1;
			vif.cb.req2 <= 1'b0;
	  end






    // this.vif.cb.inp_1 <= 1'b0;
    // this.vif.cb.inp_2 <= 22;
    // repeat (5) @ (this.vif.cb);
    `uvm_info (log_id, "End of main", UVM_MEDIUM)
  endtask : main
endclass : mux_bus_test

module mux_bus_go2uvm;
  timeunit 1ns;
  timeprecision 1ns;
  parameter VW_CLK_PERIOD = 10;

  // Simple clock generator
  bit clk ;
  always # (VW_CLK_PERIOD/2) clk <= ~clk;

  // Interface instance
  mux_bus_if mux_bus_if_0 (.*);

  // Connect TB clk to Interface instance clk

  // DUT instance
  mux_bus mux_bus_0 (.clk(clk),
			.rst_n(mux_bus_if_0.rst_n),
			.bus_select(mux_bus_if_0.bus_select),
			.bus1(mux_bus_if_0.bus1),
			.req1(mux_bus_if_0.req1),
			.req2(mux_bus_if_0.req2),
			.ack1(mux_bus_if_0.ack1),
			.ack2(mux_bus_if_0.ack2)
			);


  // Using VW_Go2UVM
  mux_bus_test mux_bus_test_0;
  initial begin : go2uvm_test
    mux_bus_test_0 = new ();
    // Connect virtual interface to physical interface
    mux_bus_test_0.vif = mux_bus_if_0;
    // Kick start standard UVM phasing
    run_test ();
  end : go2uvm_test
endmodule : mux_bus_go2uvm

