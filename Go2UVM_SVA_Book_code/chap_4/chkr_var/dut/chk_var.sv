//checker chkr_c_test (
//        input logic clk, a, b, d,
//        input int min, 
//        input untyped max);  // must be untyped if actual can be $
//    ap_ok_in_a_checker: assert property(@ (posedge clk)
//       a |-> ##[min:max] b); // legal, actual must a constant expression, or $ if used in upper bound
//endchecker: chkr_c_test
// chk_var.sv
`timescale 1ns/1ns
package mem_pkg;
    parameter SIZE          = 8;
    parameter ADDR_WIDTH    = 10;
    parameter DATA_WIDTH    = 8;
endpackage: mem_pkg
import mem_pkg::*;
checker c_mem (
        input clk_ev, 
        input logic rd, wr, 
        input logic[SIZE-1:0] addr, 
        input logic[DATA_WIDTH-1:0] rd_data, wr_data);
    logic [(SIZE-1):0] [DATA_WIDTH-1:0]  mem;   // memory declaration as scoreboard 
    default clocking cb_clk @ (clk_ev);  endclocking 
    ap_mem: assert property(rd |-> mem[addr]==rd_data);  // check rd_data against scoreboard 
    always_ff @ (clk_ev)  if(wr) mem[addr] = wr_data; // write into scoreboard memory
endchecker: c_mem

module top5(input clk,rd,wr);//input  min=1, max=100,input [7:0] addr,input [DATA_WIDTH-1:0] rd_data, wr_data,input [(SIZE-1):0] [DATA_WIDTH-1:0]  mem  ); 
  //  bit clk, rd, wr;
  int min=1, max=100;  
  logic[7:0] addr; 
  logic[DATA_WIDTH-1:0] rd_data, wr_data; 
  logic [(SIZE-1):0] [DATA_WIDTH-1:0]  mem;  
   
    c_mem c_mem1(clk, rd, wr,addr,rd_data,wr_data); //addr, rd_data, wr_data); 
endmodule : top5 

