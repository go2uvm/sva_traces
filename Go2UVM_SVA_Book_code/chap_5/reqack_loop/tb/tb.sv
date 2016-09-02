
 -----/\----- EXCLUDED -----/\----- */

module top1();
timeunit 1ns;
timeprecision 1ns;
 
  logic clk, enb, reset_n;
  logic [2:0] req, ack, done, intrpt;
// ***************** CHECKER EQUIVALENT  **************************************  
      //default clocking @(posedge clk); endclocking
    `define max_cp0 5
    logic req_delay_cp0;
    default clocking @(posedge clk); endclocking
       `define max_cp1 2
      `define max_cp1a 3      
   
  m_equivalent dut(.*);
endmodule : top1

