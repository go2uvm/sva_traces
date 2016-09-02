//checker chkr_c_test (
//        input logic clk, a, b, d,
//        input int min, 
//        input untyped max);  // must be untyped if actual can be $
//    ap_ok_in_a_checker: assert property(@ (posedge clk)
//       a |-> ##[min:max] b); // legal, actual must a constant expression, or $ if used in upper bound
//endchecker: chkr_c_test
`timescale 1ns/1ns
package cache_ctl_pkg;
    //parameter MEM_DATA_WIDTH = 8;
    parameter MAIN_MEM_ADDRESS_WIDTH = 10;
    parameter CACHE_SIZE = 8;
    parameter CACHE_MEM         = 8;
    parameter MEM_ADDR_WIDTH    = 10;
    parameter MEM_DATA_WIDTH    = 8;
    parameter MAIN_MEM          = 1024;
    //  parameter     RST_WIDTH       = 4;
    // parameter MEM_SELECT  = 3;  // 1== slow, 2== medium, 3==fast // not used 
    parameter MEM_CYCLES = 3;
    //  typedef enum bit [1:0] {RST, WR, RD} cache_op;
    // Used for the FIFO
    parameter BIT_DEPTH = 3; // 2**BIT_DEPTH = depth of fifo 
    parameter FULL = 7;    // int'(2** BIT_DEPTH -1);
    parameter WIDTH = 32;

endpackage: cache_ctl_pkg
import cache_ctl_pkg::*;
module m_c_test #(mn=0, mx=20) (
        input logic clk, a, b, d,
        input int min, 
        input int max,
        input logic[7:0] addr, 
        input logic[MEM_DATA_WIDTH-1:0] data, 
        input logic [(CACHE_SIZE-1):0] [MEM_DATA_WIDTH-1:0]  cache_mem);   
//    ap_error_in_a_module: assert property(@ (posedge clk)
//       a |-> ##[min:max] b); // illegal in a module, legal in a checker
//       // Range must be bounded by constant expressions.  
    default clocking cb_clk @ (posedge clk);  endclocking 
    ap_mem: assert property(a |-> cache_mem[addr]==data);
    ap_ok_in_module: assert property(@ (posedge clk) // using parameters
        a |-> ##[mn:mx] b); 
endmodule: m_c_test

module top2(input clk,a=1,b=1,d,input logic[7:0]addr,input logic[MEM_DATA_WIDTH-1:0] data,input logic [(CACHE_SIZE-1):0] [MEM_DATA_WIDTH-1:0]  cache_mem,output logic [2:0]  a3, b3); 
   int min=1, max=100; 
   /* bit clk, a=1, b=1, d;
     
    logic[7:0] addr; 
    logic[MEM_DATA_WIDTH-1:0] data; 
    logic [(CACHE_SIZE-1):0] [MEM_DATA_WIDTH-1:0]  cache_mem;  

    //single assignment rule 
    logic [2:0]  a3, b3; */
    always @ (clk) begin : c_a1
        a3[1:0] <= 2'b00; 
        a3[2:1] <= 2'b11;   //  SAR violation  Bit 1 assigned twice 
    end 

    // chkr_c_test c1(clk, a, b, d, 1, $); // Instance of a checker 
    m_c_test #1 c2  (clk, a, b, d, min, max, addr, data, cache_mem); // range defined in parameters
endmodule : top2 

