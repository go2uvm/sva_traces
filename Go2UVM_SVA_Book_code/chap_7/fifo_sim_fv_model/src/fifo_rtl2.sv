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
//import fifo_pkg::*;
module fifo ( clk, reset_n, 
             empty,
             almost_empty,
             almost_full,
             full,
             data_out,
             error,
             data_in,
             push,
             pop);
  timeunit 1ns;  timeprecision 100ps;
 // ==== from package:
  parameter BIT_DEPTH = 4; // 2**BIT_DEPTH = depth of fifo 
  parameter FULL = 15;    // int'(2** BIT_DEPTH -1);
  parameter ALMOST_FULL = 10; // int'(3*FULL / 4);
  parameter ALMOST_EMPTY = 4;  //int'(FULL/4);
  parameter WIDTH = 32;
  typedef logic [WIDTH-1 : 0] word_t;
  typedef word_t [0 : (2**BIT_DEPTH-1)] buffer_t;
// =====
 input clk;
 input reset_n;
 output empty;
 output almost_empty;
 output almost_full;
 output full;
 output word_t data_out;
 output error;
 input word_t data_in;
 input push;
 input pop;
// =====
  logic [BIT_DEPTH-1 : 0] wr_addr; // write fifo address
  logic [BIT_DEPTH-1 : 0] rd_addr; // read fifo address  
  buffer_t buffer; // fifo storage
  parameter shiftVal = int'(2**BIT_DEPTH) ;

  // Push on full with no pop error 
  property p_push_error; 
    @ (posedge clk) 
       not (push && full && !pop); 
  endproperty : p_push_error
  ap_push_error_1 : assert property (p_push_error);
  // mp_push_error : assume property (p_push_error);
  
  // No pop on empty 
  property p_pop_error; 
   @ (posedge clk) 
       not (pop && empty); 
  endproperty : p_pop_error
  ap_pop_error_1 : assert property (p_pop_error);
 // mp_pop_error : assume property (p_pop_error);
  
  // RTL Detailed design
  logic [1:0]            push_pop;
  // Defining control for maintenance of FIFO word count
  assign             push_pop = {push , pop};    // temporary concatenation 
  // providing READ data to output
  assign data_out = buffer[rd_addr];

  // purpose: writes data from FIFO and controls
  //          words within the FIFO.  It also provides the READ and
  //          WRITE Fifo Addresses. 
 
  always @ (posedge clk or negedge reset_n) 
    begin 
    if (!reset_n)  
        begin  // asynchronous reset (active low)
          rd_addr         <= 0;
          wr_addr         <= 0;
        end
      else
        begin
          case (push_pop)
        2'b00 :
        ;              // no push, no pop
            
            2'b01 : 
              begin                   // no push, pop for READ 
                rd_addr         <= (rd_addr+1) % shiftVal;
              end   
            2'b10 :                    // push for WRITE, no pop
              begin              
                wr_addr         <= (wr_addr + 1) % shiftVal;
                buffer[wr_addr] <= data_in;
              end
       2'b11 :                    // push for WRITE, pop for READ
              begin
                 rd_addr <= (rd_addr+1) % shiftVal;
                wr_addr <= (wr_addr + 1) % shiftVal;
                buffer[wr_addr] <= data_in;
              end
           default  :
           begin
 /*             a_illegal_fifo_cmd_1 : assert (1'b0) else
                 $warning ("%0t %0m Meta value detected in FIFO command, push_pop %2b ",
                           $time, push_pop);
 */
		a_illegal_fifo_cmd_1 : assert property (1'b0) ;
           end
           
           endcase
        end //else
    end //always

  // Reporting of flags
  // properties used as guide for this design since they define
  // the requirements
  
  assign  error = (pop && empty) || (push && full && !pop);
  assign full = (wr_addr - rd_addr)% shiftVal == FULL;
  assign empty = (wr_addr == rd_addr);
  assign almost_full = (wr_addr - rd_addr) % shiftVal >= ALMOST_FULL;
  assign almost_empty = (wr_addr - rd_addr)% shiftVal <= ALMOST_EMPTY;
  

endmodule : fifo
