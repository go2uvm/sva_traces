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
// compile fifo_pkg_include.sv first 
// --------------------------------------------------
// INTERFACE of FIFO
import fifo_pkg::*;
interface fifo_if(input wire clk, reset_n);
  timeunit 1ns;
  timeprecision 100ps;
  logic push; // push data into the fifo
  logic pop;  // pop data from the fifo
  logic almost_full;  // fifo is at 3/4 maximum level
  logic almost_empty;  // fifo is at 1/4 maximum level
  logic full;  // fifo is at maximum level
  logic empty; // fifo is at the zero level (no data)
  logic error; // fifo push or pop error   
  word_t data_in;
  word_t data_out;

  // local variables for verification purpose
  logic [BIT_DEPTH-1 : 0] wr_ptr = 0;
  logic [BIT_DEPTH-1 : 0] rd_ptr = 0;

  logic fifo_is_full;
  logic fifo_is_empty;
  logic fifo_is_almost_full;
  logic fifo_is_almost_empty;
  
  // FIFO DUV 
  modport fslave_if (output empty,
                     output almost_empty,
                     output almost_full,
                     output full,
                     output data_out,
                     output error,
                     input data_in,
                     input push,
                     input pop);

  // FIFO driver 
   modport fdrvr_if (input empty,
                     input almost_empty,
                     input almost_full,
                     input full,
                     input data_out,
                     input error,
                     output data_in,
                     output push,
                     output pop);
     
 clocking cb @(posedge clk);
    input empty;
    input almost_empty;
   input almost_full;
   input full;
   input data_out;
   input error;
   output reset_n;
   output data_in;
  output push;
  output pop;
 endclocking :cb    

  // never a push and full and no pop
  property p_push_error; 
    @ (posedge clk) 
       not (push && full && !pop); 
  endproperty : p_push_error
  ap_push_error : assert property (p_push_error);

   // never a pop on empty 
  property p_pop_error; 
   @ (posedge clk) 
       not (pop && empty); 
  endproperty : p_pop_error
  ap_pop_error : assert property (p_pop_error);

  `ifdef SV_3.1a
    property p_error_flag; 
   @ (posedge clk) 
   p_push_error or p_pop_error |=> error;
   endproperty : p_error_flag
   ap_error_flag : assert property (p_error_flag);     
  `endif
  
 
    // sequence definition, use in cover.  FIFO_B.FULL 
  sequence qFull; 
    fifo_is_full;
  endsequence : qFull

  // sequence definition, use in cover.  empty  
  sequence qEmpty; 
      fifo_is_empty;
  endsequence : qEmpty

  // sequence definition, use in cover.  almost_empty   
  sequence qAlmost_empty; 
     fifo_is_almost_empty;
   endsequence : qAlmost_empty

  // sequence definition, use in cover.  almost_full
  sequence qAlmost_full; 
     fifo_is_almost_full;
   endsequence : qAlmost_full

  // Definition of a fifo_b.full fifo, based on environment addresses.
  property p_fifo_full; 
     @ (posedge clk)   qFull |=> full; 
  endproperty : p_fifo_full
  ap_fifo_full : assert property (p_fifo_full);
  
  // Definition of an almost_fifo_b.full fifo, based on environment addresses
  property p_fifo_almost_full; 
     @ (posedge clk)   qAlmost_full |=> almost_full; 
  endproperty : p_fifo_almost_full
  ap_fifo_almost_full : assert property (p_fifo_almost_full);

  // If empty fifo, check empty flag   
  property p_fifo_empty; 
    @ (posedge clk) 
             qEmpty |-> empty; 
  endproperty : p_fifo_empty
  ap_fifo_empty : assert property (p_fifo_empty);
  
  // Flags at reset 
  property p_fifo_ptrs_flags_at_reset; 
    @ (posedge clk) 
       !reset_n |-> almost_empty && ! full && !almost_full && empty; 
  endproperty  : p_fifo_ptrs_flags_at_reset
  ap_fifo_ptrs_flags_at_reset : assert property (p_fifo_ptrs_flags_at_reset);
  
  // Flag at almost_empty state
  property p_fifo_almost_empty; 
    @ (posedge clk)  qAlmost_empty |-> almost_empty;  // BUG: should use |=> !!!! 
  endproperty : p_fifo_almost_empty
  ap_fifo_almost_empty : assert property (p_fifo_almost_empty);

 
  // ------------------------------

  always @ (posedge clk)
  begin : status_flag
    fifo_is_empty = (wr_ptr == rd_ptr);
    fifo_is_full = (wr_ptr - rd_ptr) == FULL;
    fifo_is_almost_full = (wr_ptr - rd_ptr) >= ALMOST_FULL;
    fifo_is_almost_empty = (wr_ptr - rd_ptr) <= ALMOST_EMPTY;
  end //status_flag
  default clocking  @ ( posedge clk ) ; endclocking 
   task push_task (word_t data);
     begin
       $display ("%0t %m Push data %0h ", $time, data);
	   data_in <= data;
	   push <= 1'b1;
	   pop  <= 1'b0;
       wr_ptr++;
	   ##1;
      end
    endtask : push_task 

    task pop_task;
      begin
        data_in <= 'X; // unsized Xs 
        push <= 1'b0;
        pop  <= 1'b1;
        rd_ptr++;
        ##1;
       end
    endtask : pop_task
      
    task idle_task (int num_idle_cycles);
      begin
        assert (num_idle_cycles < 10000) else 
          $warning ("%0t %0m idle_task is invoked with LARGE number of idle cycles %0d ",
                    $time, num_idle_cycles); 
        data_in <= 'X; // unsized Xs 
        push <= 1'b0;
        pop  <= 1'b0;
        repeat (num_idle_cycles) ##1;
      end
    endtask : idle_task 


endinterface : fifo_if
