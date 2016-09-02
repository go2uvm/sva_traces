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
/*`define true 1
`ifndef MULTIPLE_FILE_COMPILE 
  typedef enum {OFF, RED, YELLOW, GREEN, PRE_GREEN} lights_t; 
`endif*/

module tlight_props
  (
   input  lights_t ns_light,  // North/South light status, Main road
   input  lights_t ew_light,  // East/West light status
   input 	   ew_sensor, // East/West sensor for new car
   input 	   emgcy_sensor, // emergency sensor 
   input 	   reset_n,   // synchronous reset
   input 	   clk,       // master clock

// internal states:
   input [1:0]  ns_green_timer,
   input 	ew_green_req
   );
  timeunit 1ns;
  timeprecision 1ns;
  parameter FAIL   = 1'b0;


  // sequence defintion
  sequence qEmgcy;
    @ (posedge clk) emgcy_sensor;
  endsequence : qEmgcy
	
  // **************************************************                  
  // Safety property
  property Never_NS_EW_ALL_GREEN;
      disable iff (!reset_n) 
     not (ns_light==GREEN && ew_light==GREEN);
  endproperty : Never_NS_EW_ALL_GREEN
  Never_NS_EW_ALL_GREEN_1 : assert property(@ (posedge clk) Never_NS_EW_ALL_GREEN);
  // **************************************************  
  // State of lights at reset  
  property nsLightAtReset;
     // disable iff (!reset_n) 
     reset_n==1'b0 |=> ns_light==OFF;
  endproperty : nsLightAtReset
  nsLightAtReset_1 : assert property(@ (posedge clk) nsLightAtReset);
  //
  property ewLightAtReset;
     // disable iff (!reset_n) 
    reset_n==1'b0 |=> ew_light==OFF;
   endproperty : ewLightAtReset
  ewLightAtReset_1 : assert property(@ (posedge clk) ewLightAtReset); 
  // **************************************************  
  // State of lights during emergency
  // Lights switch from GREEN to YELLOW to RED 
  property NsLightsWhenEmergency;
     disable iff (!reset_n) 
    emgcy_sensor |=> `true[*2] ##1  ns_light==RED;
   endproperty : NsLightsWhenEmergency
  NsLightsWhenEmergency_1 : assert property(@ (posedge clk) NsLightsWhenEmergency);
  //
  property EwLightsWhenEmergency;
     disable iff (!reset_n) 
     emgcy_sensor |=> `true[*2] ##1 ew_light==RED;
  endproperty : EwLightsWhenEmergency
  EwLightsWhenEmergency_1 : assert property(@ (posedge clk) EwLightsWhenEmergency);
  // **************************************************  
  // Safety, GREEN to RED is illegal.  Need YELLOW
  property NsNeverFromGreenToRed;
     disable iff (!reset_n) 
    not (ns_light==GREEN ##1 (ns_light==RED)); 
  endproperty : NsNeverFromGreenToRed
  NsNeverFromGreenToRed_1 : assert property(@ (posedge clk) NsNeverFromGreenToRed);
  // 
  property EwNeverFromGreenToRed;
     disable iff (!reset_n) 
     not ((ew_light==GREEN) ##1 (ew_light==RED) );
  endproperty : EwNeverFromGreenToRed
  EwNeverFromGreenToRed_1 : assert property(@ (posedge clk) EwNeverFromGreenToRed);
  // **************************************************
   // The NorthSouth light is the main street light.  
  // If ns is green and no emergency or ew sensor, then next cycle is also GREEN
  property NsGreenNext;
    (ns_light==GREEN) && ($past(emgcy_sensor)==1'b0 && reset_n==1'b1 
                      &&  ew_green_req == 1'b0) |=> ns_light==GREEN;
 endproperty : NsGreenNext
 NsGreenNext_1:  assert property (@ (posedge clk) NsGreenNext);
  
  // **************************************************
  // East-West light to RED errata 3/23/05
 // //   property EwLightToRed;
// //      disable iff (!reset_n || emgcy_sensor) 
// //      (ew_green_timer==2'b11) |=>
// //        `true ##1 ew_light==RED; // abort emgcy_sensor==1'b1);
// //    endproperty : EwLightToRed
// //    EwLightToRed_1 : assert property (EwLightToRed);

  // GREEN-YELLOW at the smae time
  property NeverGreenYellow;
     not ((ew_light==GREEN && ns_light==YELLOW) ||
          (ns_light==GREEN && ew_light==YELLOW));
  endproperty : NeverGreenYellow
  NeverGreenYellow_1: assert property (@ (posedge clk) NeverGreenYellow);

  // NEW PROPERTIES 09/10/09
    // **************************************************  
  // The NorthSouth light is the main street light.  
  // It must remain GREEN for ns_green_timer == 3 before it can switch. 
  // Timer ns_green_timer will count to 3, and remain at 3 until light changes.
   property NsGreenForMin3Ccyles;
    @ (posedge clk) disable iff (!reset_n || emgcy_sensor) 
      $rose(ns_light==GREEN) && !$past(emgcy_sensor) |=> 
             ns_light==GREEN[*2]; // abort emgcy_sensor);
//              ns_light==GREEN ##1 ns_light==GREEN; // abort emgcy_sensor);					 
  endproperty : NsGreenForMin3Ccyles
  NsGreenForMin3Ccyles_1 : assert property (NsGreenForMin3Ccyles);

  // **************************************************
  // East-West North-South Lights with East-West sensor 
  // If ew_sensor is activated (new car), then light will switch for the ew_light 
  // when minimum time for ns_light is satisfied.  ew_green_timer will count to 3, 
  // at which time, the ns_green_timer will regain control of GREEN.
  
   property EwNewSensorActivation;
    @ (posedge clk) disable iff (!reset_n || emgcy_sensor) 
     ( (ew_sensor==1'b1) && $rose(ns_green_timer==2'b11 )) && !$past(emgcy_sensor) && ns_light!= RED |-> 
          ##[1:3] ns_light==YELLOW ##1 ew_light==GREEN; 
   endproperty : EwNewSensorActivation
   EwNewSensorActivation_1 : assert property (EwNewSensorActivation);
	 // End of new properties 09/10/09
 
  // Cleaned-up property for EW sensor:
  property EwNewSensorActivation_w(int del);
    @ (posedge clk) disable iff (!reset_n || emgcy_sensor) 
    ew_sensor |->  ##[0:del] ew_light==GREEN; 
   endproperty : EwNewSensorActivation_w

   EwNewSensorActivation3: assert property (EwNewSensorActivation_w(3));
 //  EwNewSensorActivation6 : assert property (EwNewSensorActivation_w(6));
   EwNewSensorActivation10 : assert property (EwNewSensorActivation_w(10));
   EwNewSensorActivation11 : assert property (EwNewSensorActivation_w(11));
   EwNewSensorActivation12 : assert property (EwNewSensorActivation_w(12));


endmodule : tlight_props

bind trafficlight tlight_props tlight_props1 (.*);

