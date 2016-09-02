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
// -------------------------------------------------- 
// PROPERTY MODULE for FIFO
// This module is used for verification of the FIFO, and is 
// intended to be bound (with the SystemVerilog "bind") to the DUV
//module fifo_props (input clk,input reset_n);
module fifo_props (
input  logic      clk,          
input  logic      reset_n,      
input  logic      empty,        
input  logic      almost_empty, 
input  logic      almost_full,  
input  logic      full,         
input  logic      [31:0] data_out,     
input  logic      error,        
input  logic      [31:0]data_in,      
input  logic      push,         
input  logic      pop          
);
      //fifo_if fifo_if(.clk(clk),.reset_n(reset_n));
  //    fifo_if fifo_if(.*);
/*      fifo fifo_rtl_2(
             .clk          (clk),
             .reset_n      (reset_n), 
             .empty        (empty),
             .almost_empty (almost_empty),
             .almost_full  (almost_full),
             .full         (full),
             .data_out     (data_out),
             .error        (error),
             .data_in      (data_in),
             .push         (push),
             .pop          (pop)); // instantiation of fifo DUV

*/
      //module fifo_props ( fifo_if fifo_if); 
     
  timeunit 1ns;
  timeprecision 100ps;

// Activating reset during interesting corner cases
// is covered via cover directives.

  property p_t1_full;  @ (posedge clk) 
    full ##1 reset_n==0;
  endproperty : p_t1_full
  cp_t1_full_1: cover property (p_t1_full);
  

  property p_t2_afull;  @ (posedge clk) 
    almost_full ##1 reset_n==0;
  endproperty : p_t2_afull
  cp_t2_afull_1: cover property (p_t2_afull);
  
  property p_t3_empty;  @ (posedge clk) 
     empty ##1 reset_n==0;
  endproperty : p_t3_empty
  cp_t3_empty_1: cover property (p_t3_empty);
  
  property p_t4_aempty;  @ (posedge clk) 
    almost_empty ##1  reset_n==0;
  endproperty : p_t4_aempty
  cp_t4_aempty_1 : cover property (p_t4_aempty);
  

  property p_push_pop_sequencing;
      @ (posedge clk) push |=> ##[0:$] pop;
  endproperty : p_push_pop_sequencing
     
  // coverage of sequences 
  cp_push_pop_sequencing  : cover property  (p_push_pop_sequencing);
 
  c_qFull :               cover property  ( @ (posedge clk) full);
  c_qEmpty  :             cover property  (@ (posedge clk)  empty);
  
  c_qAlmost_empty :       cover property  (@ (posedge clk)  almost_empty);
  c_qAlmost_full :        cover property  (@ (posedge clk)  almost_full);
  
endmodule : fifo_props   
bind fifo fifo_props fifo_props_1(.*);
