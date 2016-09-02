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
// package t_pkg;  
`define true 1 
typedef enum {OFF, RED, YELLOW, GREEN, PRE_GREEN} lights_t;
// endpackage : t_pkg 

// import t_pkg::*;		  
module trafficlight
  (
   output  lights_t ns_light,  // North/South light status, Main road
   output  lights_t ew_light,  // East/West light status
   input 	   ew_sensor, // East/West sensor for new car
   input 	   emgcy_sensor, // emergency sensor 
   input 	   reset_n,   // synchronous reset
   input 	   clk       // master clock
   );
  timeunit 1ns;
  timeprecision 100ps;
  parameter FAIL   = 1'b0;
  logic [1:0]    ns_green_timer;  // timer for NS light in Green
  logic [1:0]    ew_green_timer;  // timer for EW light in GREEN
  logic          ew_green_req; 
  
  //| # Pattern name # NorthSouth 
  //| # Problem #  The NorthSouth light is the main street light.   It must remain 
  //| GREEN for ns_green_timer == 3 before it can switch.  Timer ns_green_timer
  //|  will count to 3, and remain at 3 until light changes.  If ew_sensor is activated 
  //| (new car), then light will switch for the East-West light  when the minimum 
  //| time for ns_light is satisfied (i.e., 3 cycles).  The ew_green_timer will count to 3, 
  //| at which time, the ns_green_timer will regain control of GREEN.  This gives the 
  //| North-South traffic a higher priority than the East-West traffic.
  //| An emgcy_sensor shall turn all lights to RED.
  //| Going from GREEN to RED requires a YELLOW for 1 cycle. 
  //| # Motivation # Simplicity and conformity.
  //| # Context # 
  //| # Solution # 
  //|    2 timers ns_green_timer, ew_green_timer
  //|    Light cycle: GREEN (3 cycle min), YELLOW (1 cycle), RED (until GREEN).
  //|    
  //| # Considerations #  

  // Based upon the requirements, several assertions can be expressed prior to 
  // writing the RTL.  Below are the assertions written for this design.  

  
  lights_t ns_state  ;   // register that holds the current state of the FSM
  lights_t next_ns_state ; // register that holds the next state of the FSM 
  lights_t     ew_state  ;   // register that holds the current state of the FSM
  lights_t    next_ew_state ; // register that holds the next state of the FSM 
  
  
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
      case (ns_state)
		OFF   : next_ns_state = GREEN;
		RED   : 
		 //  if (emgcy_sensor==1'b0 && ew_green_timer==2'b11)
		 //	next_ns_state= GREEN; // Error // priority to North South
		  if (ew_green_timer==3'b11) next_ns_state=GREEN;
		YELLOW: next_ns_state=RED;
		GREEN :
		  if (emgcy_sensor==1'b1) next_ns_state=YELLOW;
		  else if (ns_green_timer==2'b11 && ew_sensor==1'b1) next_ns_state=YELLOW;
		default: next_ns_state= ns_state;
      endcase
	end
  
  // EW FSM machine 
  always @ (*)
	begin 
	  next_ew_state = ew_state; // default
      case (ew_state)
		OFF   : next_ew_state = RED;
		RED   : 
		  if (ns_green_timer==3'b11 && ew_sensor==1'b1) next_ew_state=PRE_GREEN;
		PRE_GREEN : next_ew_state = GREEN;
		YELLOW: next_ew_state=RED;
		GREEN :
		  if (emgcy_sensor==1'b1) next_ew_state=YELLOW;
		  else if (ew_green_timer==2'b11) next_ew_state=YELLOW;
      endcase
	end
  
  // NS Counter
  // ** fix, need to latch counter to 3 
   always @ ( posedge clk )
	 if (reset_n==1'b0 || ns_state==YELLOW)   ns_green_timer <= 2'b00;
	 else if (ns_green_timer != 2'b11) ns_green_timer <= ns_green_timer + 2'b01;
    

  // EW Counter
   always @ ( posedge clk )
	 if (reset_n==1'b0 || ew_state==YELLOW)   ew_green_timer <= 2'b00;
     // Bad assumption here 
	 else if (ns_state==RED) ew_green_timer<= ew_green_timer + 2'b01;

  assign ns_light = ns_state;

  assign ew_light = (ew_state==PRE_GREEN) ? RED : ew_state;
  
endmodule : trafficlight

