/*
Code for use with the book
"SystemVerilog Assertions Handbook, 2nd edition"ISBN  878-0-9705394-8-7

Code is copyright of VhdlCohen Publishing & CVC Pvt Ltd., copyright 2009 

www.systemverilog.us  ben@systemverilog.us
www.cvcblr.com, info@cvcblr.com

All code provided in this book and in the accompanied website is distributed
 with *ABSOLUTELY NO SUPPORT* and *NO WARRANTY* from the authors.  Neither
the authors nor any supporting vendors shall be liable for damage in connection
with, or arising out of, the furnishing, performance or use of the models
provided in the book and website.
*/
`define true 1
//import tlight_pkg::*;
typedef enum {OFF, RED, YELLOW, GREEN, PRE_GREEN} lights_t; 

module trafficlight
  (
   output  lights_t ns_light,  // North/South light status, Main road
   output   lights_t ew_light,  // East/West light status
   input 	   ew_sensor, // East/West sensor for new car
   input 	   emgcy_sensor, // emergency sensor 
   input 	   reset_n,   // synchronous reset
   input 	   clk       // master clock
   );
  timeunit 1ns;   timeprecision 100ps;
  parameter FAIL   = 1'b0;
  logic [1:0]    ns_green_timer;  // timer for NS light in Green
  lights_t     ns_state  ;   // register that holds the current state of the FSM
  lights_t     next_ns_state ; // register that holds the next state of the FSM 
  lights_t     ew_state  ;   // register that holds the current state of the FSM
  lights_t    next_ew_state ; // register that holds the next state of the FSM 
  logic 	  ew_green_req; // East-West request to have light to GREEN
  logic 	  ew_green_grant; // Grant from North-South controller 
  logic 	  ew_2red_cmd; // East-West to RED command from North-South controller
  logic       ew_sensor_r;  // registeres input 
  logic 	  emgcy_sensor_r; // registeres input 
  logic 	  ew_sensor_ack;  // acknowledge to accept new inputs 
  logic 	  emgcy_sensor_ack; // acknowledge to accept new inputs 
  logic       ew_is_green; // for verification 
  logic       ns_is_green; // for verification

 
 
  assign ew_is_green = (ew_light==GREEN) ? 1'b1 : 1'b0;
  assign ns_is_green = (ns_light==GREEN) ? 1'b1 : 1'b0; 
  
  
  // North South FSM 
  always @ ( posedge clk )
	if (reset_n==1'b0) ns_state <= OFF;
	else  ns_state <= next_ns_state;

   // East West  FSM 
  always @ ( posedge clk )
	if (reset_n==1'b0) ew_state <= OFF;
	else  ew_state <= next_ew_state;

  // NS FSM machine 
  always @ (*)
	begin 
	  next_ns_state = ns_state; // default
	  ew_2red_cmd = 1'b0;  // default
	  ew_green_grant=1'b0; // default
	  emgcy_sensor_ack = 1'b1; // accept new inputs into reg 
	  
      case (ns_state)
		OFF   : begin 
		  next_ns_state = GREEN;
    	  ew_2red_cmd = 1'b1;
		end
		RED   : begin 
		  if (emgcy_sensor_r==1'b0 && ns_green_timer==2'b11) begin 
		 	next_ns_state= PRE_GREEN;  
			ew_2red_cmd = 1'b1;
		  end
		end
		PRE_GREEN: begin
		  if (emgcy_sensor_r==1'b0) next_ns_state= GREEN;
		  else if (emgcy_sensor_r==1'b1) next_ns_state=RED;
		end 
		YELLOW: begin 
		  next_ns_state=RED;
		  if (emgcy_sensor_r==1'b0 && ew_green_req==1'b1)
			ew_green_grant=1'b1;
		end 
		GREEN : begin 
		  if (emgcy_sensor_r==1'b1 || (ew_green_req==1'b1 && ns_green_timer==2'b11))
			  next_ns_state=YELLOW;
		  if (emgcy_sensor_r==1'b1) emgcy_sensor_ack=1'b0;
		end 
		default: next_ns_state= ns_state;
      endcase // case(ns_state)
	  if (emgcy_sensor_r==1'b1) ew_2red_cmd = 1'b1; // override 
	end

  // East-West GREEN light request
  always @ (posedge clk) begin
	if (ew_sensor_r==1'b1) begin 
	  ew_green_req <= 1'b1;
	  ew_sensor_ack <= 1'b0;  // no accept new inputs into reg
	end
    // 11/11/03  Change the else if to if
	// Latching condition  causing the ew_green_req to never drop
    if (ew_green_grant==1'b1) begin 
	  ew_green_req <= 1'b0;
	  ew_sensor_ack <= 1'b1;  // accept new inputs into reg
	end
	// moved the reset test to end for higher priority 
	if (reset_n==1'b0) begin 
	  ew_green_req <= 1'b0;
	  ew_sensor_ack <= 1'b1;  // accept new inputs into reg
	end

  end
  
  // EW FSM machine 
  always @ (*) 	begin 
	next_ew_state = ew_state; // default
	if (ew_2red_cmd == 1'b1)
	  if (ew_state==GREEN) next_ew_state=YELLOW;
	  else next_ew_state = RED;
	else if (ew_green_grant==1'b1) next_ew_state = GREEN; // 11/11/03
	else if (ew_state==YELLOW) next_ew_state = RED;  // 11/11/03 safetty
  end
  
  // NS Counter
   always @ ( posedge clk )
	 if (reset_n==1'b0 || ns_state==YELLOW || ew_2red_cmd == 1'b1)   ns_green_timer <= 2'b00;
	 else if (ns_green_timer != 2'b11) ns_green_timer <= ns_green_timer + 2'b01;
    

  // EW Counter
  // always @ ( posedge clk )
  // 	 if (reset_n==1'b0 || ew_state==RED)   ew_green_timer <= 2'b00;
  // Bad assumption here 
  //	 else if (ew_state==GREEN && 
  //            ew_green_timer <=2'b11) ew_green_timer<= ew_green_timer + 2'b01;

  // Sensor registers
   always @ (posedge clk) begin
	 if (emgcy_sensor_ack==1'b1) emgcy_sensor_r <= emgcy_sensor;
	 if (ew_sensor_ack==1'b1) ew_sensor_r <= ew_sensor;
	 // 11/11/03 Need to drop the ew_sensor_r if ew_green_grant
	 if (ew_green_grant==1'b1) ew_sensor_r <= 1'b0;
	 if (reset_n==1'b0) begin
	   emgcy_sensor_r <= 1'b0;
	   ew_sensor_r <= 1'b0;
	 end 	 
   end
  

  assign ns_light = (ns_state==PRE_GREEN) ? RED : ns_state; // 

  assign ew_light = ew_state;
  
endmodule : trafficlight // trafficlightok


