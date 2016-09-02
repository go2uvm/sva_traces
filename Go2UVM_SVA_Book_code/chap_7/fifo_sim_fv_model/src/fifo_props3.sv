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

module fifo_props (clk, reset_n,
	     empty,
             almost_empty,
             almost_full,
             full,
             data_out,
             error,
             data_in,
             push,
             pop,

	// Internal states:
	     buffer,
	     wr_ptr,
	     rd_ptr);
  timeunit 1ns;   timeprecision 100ps;
 // ==== from package (needed for data type)
  parameter BIT_DEPTH = 4; // 2**BIT_DEPTH = depth of fifo 
  parameter DEPTH = 2**BIT_DEPTH ;
  parameter FULL = DEPTH - 1;    // int'(2** BIT_DEPTH -1);
  parameter ALMOST_FULL = 10; // int'(3*FULL / 4);
  parameter ALMOST_EMPTY = 4;  //int'(FULL/4);
  parameter WIDTH = 32;
  typedef logic [WIDTH-1 : 0] word_t;
  typedef word_t [0 : (2**BIT_DEPTH-1)] buffer_t;

// =====
 input clk;
 input reset_n;
 input empty;
 input almost_empty;
 input almost_full;
 input full;
 input word_t data_out;
 input error;
 input word_t data_in;
 input push;
 input pop;

 input logic [BIT_DEPTH-1 : 0] wr_ptr ;
 input logic [BIT_DEPTH-1 : 0] rd_ptr ;
 input buffer_t buffer; // fifo storage

// =====
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
  

// turned unbounded into bounded
  property p_push_pop_sequencing;
      @ (posedge clk) push |=> ##[0:99] pop;
  endproperty : p_push_pop_sequencing
     
  // coverage of sequences 
  cp_push_pop_sequencing  : cover property  (p_push_pop_sequencing);

 
// ============= Interface Properties:

// local variables for verification purpose
// define status

function int fill_level;
fill_level  = (wr_ptr - rd_ptr) % DEPTH;
endfunction

function fifo_is_empty_fn;
fifo_is_empty_fn  = fill_level() == 0;
endfunction

function fifo_is_full_fn;
fifo_is_full_fn  = fill_level()  == FULL;
endfunction

function fifo_is_almost_full_fn;
fifo_is_almost_full_fn  = fill_level()  >= ALMOST_FULL;
endfunction

function fifo_is_almost_empty_fn;
fifo_is_almost_empty_fn  = fill_level() <= ALMOST_EMPTY;
endfunction

    property p_error_flag; 
   @ (posedge clk) 
   (push && full && !pop) || (pop && empty) == error;
   endproperty : p_error_flag
   ap_error_flag : assert property (p_error_flag);     
 
//begin: no_error   
  // never a push and full and no pop
  property p_push_error; 
    @ (posedge clk) 
       not (push && full && !pop); 
  endproperty : p_push_error
 // ap_push_error : assert property (p_push_error);
 ap_push_error : assume property (p_push_error);

   // never a pop on empty 
  property p_pop_error; 
   @ (posedge clk) 
       not (pop && empty); 
  endproperty : p_pop_error
 // ap_pop_error : assert property (p_pop_error);
  ap_pop_error : assume property (p_pop_error);


 // Definition of a fifo_b.full fifo, based on environment addresses.
  property p_fifo_full; 
    @ (posedge clk)   fifo_is_full_fn() == full; 
 endproperty : p_fifo_full
  ap_fifo_full : assert property (p_fifo_full);
  
  // Definition of an almost_fifo_b.full fifo, based on environment addresses
  property p_fifo_almost_full; 
  @ (posedge clk)   fifo_is_almost_full_fn()  == almost_full; 

  endproperty : p_fifo_almost_full
  ap_fifo_almost_full : assert property (p_fifo_almost_full);

  // If empty fifo, check empty flag   
  property p_fifo_empty; 
    @ (posedge clk) 
             fifo_is_empty_fn() == empty; 
  endproperty : p_fifo_empty
  ap_fifo_empty : assert property (p_fifo_empty);
  
 // Flag at almost_empty state
  property p_fifo_almost_empty; 
    @ (posedge clk)  fifo_is_almost_empty_fn() == almost_empty;  
   endproperty : p_fifo_almost_empty
  ap_fifo_almost_empty : assert property (p_fifo_almost_empty);


  // Flags at reset 
  property p_fifo_ptrs_flags_at_reset; 
    @ (posedge clk) 
       !reset_n |-> almost_empty && ! full && !almost_full && empty; 
  endproperty  : p_fifo_ptrs_flags_at_reset
  ap_fifo_ptrs_flags_at_reset : assert property (p_fifo_ptrs_flags_at_reset);
  
  c_fifo_is_full:               cover property  (@ (posedge clk)  fifo_is_full_fn());
  c_fifo_is_empty  :            cover property  (@ (posedge clk)  fifo_is_empty_fn());
  
  c_fifo_is_almost_empty :      cover property  (@ (posedge clk)  fifo_is_almost_empty_fn());
  c_fifo_is_almost_full :       cover property  (@ (posedge clk)  fifo_is_almost_full_fn());
 
  c_fifo_full_alm_empty :       cover property  (@ (posedge clk) disable iff (!reset_n) fifo_is_full_fn() ##[0:16] fifo_is_almost_empty_fn());

  c_fifo_fill_twice :       	cover property  (@ (posedge clk) disable iff (!reset_n) fifo_is_full_fn() ##[0:16] fifo_is_empty_fn() ##[0:16] fifo_is_full_fn());

property  arith_test;
int diff;
logic [4:0] diff5;
logic [3:0] diff4;

(wr_ptr == 1 && rd_ptr == 2, 
	diff = wr_ptr - rd_ptr, 
	diff5 = wr_ptr - rd_ptr, 
	diff4 = wr_ptr - rd_ptr) 
|-> 
//	diff == 15 && 
//	diff5 == 15 && 
	diff4 == 15 && 
//	wr_ptr - rd_ptr == 15 &&
	fifo_is_full_fn() && 
	full;
endproperty
//a_arith_test:  assert property  (@ (posedge clk) disable iff (!reset_n) arith_test);


property p_push_data; 
word_t data;
logic [BIT_DEPTH-1 : 0] ptr;
       (push, data = data_in, ptr = wr_ptr) |=> buffer[ptr] == data; 
  endproperty : p_push_data
  ap_push_data : assert property (@ (posedge clk) disable iff (!reset_n) p_push_data);

property p_pop_data; //===== From book:
       pop |-> data_out == buffer[rd_ptr]; 
  endproperty : p_pop_data
  ap_pop_data : assert property (@ (posedge clk) disable iff (!reset_n) p_pop_data);

//===== correct pointer manuipulation:
  property p_push; 
    @ (posedge clk)  disable iff (!reset_n) 
	push |=> wr_ptr == ($past(wr_ptr) + 1 ) % DEPTH;  
  endproperty : p_push
  ap_push : assert property (p_push);

  property p_pop; 
    @ (posedge clk)  disable iff (!reset_n) 
	pop  |=> rd_ptr == ($past(rd_ptr) + 1 ) % DEPTH;  
  endproperty : p_pop
  ap_pop: assert property (p_pop);

 property p_nopush; 
    @ (posedge clk)  disable iff (!reset_n) 
	!push |=> wr_ptr == $past(wr_ptr);  
  endproperty : p_nopush
  ap_nopush : assert property (p_nopush);

  property p_nopop; 
    @ (posedge clk)  disable iff (!reset_n) 
	!pop  |=> rd_ptr == $past(rd_ptr);  
  endproperty : p_nopop
  ap_nopop: assert property (p_nopop);

//end // no_error

endmodule : fifo_props   

// =====
  bind fifo fifo_props fifo_props_1 (.wr_ptr(wr_addr), .rd_ptr(rd_addr),  .*);
