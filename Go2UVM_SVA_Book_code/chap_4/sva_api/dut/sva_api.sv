module k(input clk,rst);
//logic clk ,rst;
//timeunit 1ns; timeprecision 100ps;
//Design has 3 assertions named as follows:
//ap_rst_checks,ap_arm_arith_instructions,ap_arm_logical_nstructions
//The Definitions Of Those Assertuions are not shown here as the goal of this example is to use vpiCallBack
ap_rst_checks : cover property (@(posedge clk) rst ##[1:3] !rst); 
final
 begin : call_api
$assert_cov; //call to API C-code function
end :call_api


endmodule :k

