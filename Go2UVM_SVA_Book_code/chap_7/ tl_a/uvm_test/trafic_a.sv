interface tlight_if (input clk);
typedef enum {OFF, RED, YELLOW, GREEN, PRE_GREEN} lights_t;

   lights_t  ns_light;
   lights_t  ew_light;
   logic ew_sensor;
   logic emgcy_sensor;
   logic reset_n;
 //  logic ew_green_req;
   //logic [1:0] ns_green_timer;
  // logic ew_green_grant,ew_2red_cmd;
  //logic ew_sensor_r,ew_sensor_ack,emgcy_sensor_r;
  //logic emgcy_sensor_ack,ew_is_green,ns_is_green; 

   clocking cb @(posedge clk);
     input    ns_light;
     input     ew_light;
     output  ew_sensor;
     output  emgcy_sensor,reset_n;
    // output  ns_green_timer;
     //inout 	  ew_green_req; // East-West request to have light to GREEN
     //inout 	  ew_green_grant; // Grant from North-South controller 
   // inout 	  ew_2red_cmd; // East-West to RED command from North-South controller
 // inout       ew_sensor_r;  // registeres input 
 // inout 	  emgcy_sensor_r; // registeres input 
 // inout 	  ew_sensor_ack;  // acknowledge to accept new inputs 
  //inout 	  emgcy_sensor_ack; // acknowledge to accept new inputs 
 // inout       ew_is_green; // for verification 
 // inout       ns_is_green; 

   endclocking : cb
 endinterface : tlight_if  

 import uvm_pkg::*;
   `include "uvm_macros.svh"
 
 import vw_go2uvm_pkg::*;

 class uvm_sva_test extends go2uvm_base_test;
   virtual tlight_if vif;
    task reset ();
    `uvm_info(log_id, "Start of reset", UVM_MEDIUM)
    repeat(10) @ (vif.cb);
    `uvm_info(log_id, "End of reset", UVM_MEDIUM)
  endtask : reset

  task main();
     int i;
    `uvm_info(log_id, "Start of Test", UVM_MEDIUM)
            @ (vif.cb);
    `uvm_info(log_id, "End of Test", UVM_MEDIUM)
    endtask : main

endclass : uvm_sva_test

//`timescale 1ns/100
module top;
   timeunit 1ns;
   timeprecision 1ns;

  logic clk = 0;
  initial forever #10 clk = !clk;
 
  //Instantiate the Interface 
  tlight_if if_0 (.*);

  trafficlight dut (.clk(clk),
                     .ns_light(if_0.ns_light),
		     .ew_light(if_0.ew_light),
		     .ew_sensor(if_0.ew_sensor),
		     .emgcy_sensor(if_0.emgcy_sensor),
		     .reset_n(if_0.reset_n)
                    // .ew_green_req(if_0.ew_green_req),
		     //.ns_green_timer(if_0.ns_green_timer), 
                    // .ew_green_grant(if_0.ew_green_grant),
                     //.ew_is_green(if_0.ew_is-green),
                    // .ns_is_green(if_0.ns_is_green),
                     //.emgcy_sensor_ack(if_0.emgcy_sensor_ack),
                     //.ew_sensor_ack(if_0.ew_sensor_ack),
                    // .ew_sensor_r(if_0.ew_sensor_r),
                    // .ew_2red_cmd(if_0.ew_2red_cmd)  
                    );

 uvm_sva_test test_0;

  initial begin
    test_0 = new();
    test_0.vif = if_0;
    run_test();
   end
  endmodule 
