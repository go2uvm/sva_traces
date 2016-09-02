//typedef enum {OFF, RED, YELLOW, GREEN, PRE_GREEN} lights_t;

module top1;
timeunit 1ns;
  timeprecision 1ns;

typedef enum {OFF, RED, YELLOW, GREEN, PRE_GREEN} lights_t;


    lights_t ns_light;
   lights_t ew_light;
  logic ew_sensor;
  logic emgcy_sensor;
  logic reset_n;
  logic clk;
 // logic [1:0] ns_green_timer;
  //logic ew_green_req,ew_green_grant,ew_2red_cmd;
 // logic ew_sensor_r,ew_sensor_ack,emgcy_sensor_r;
  //logic emgcy_sensor_ack,ew_is_green,ns_is_green;

 trafficlight dut (.*);
  default clocking @(posedge clk);
 endclocking
endmodule : top1
 
