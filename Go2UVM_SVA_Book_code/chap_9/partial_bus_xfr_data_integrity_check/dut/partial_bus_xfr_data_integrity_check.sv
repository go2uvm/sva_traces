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
//   The data received from an interface (with wr control) must be properly 
//   transferred to the receiving hardware (with rd control).
//   The data is sourced at a 33 MHz rate and is extracted at a 25 MHz rate.
//   The receiver uses a ready4data signal to throttle the transmission
//   of one Kilo-words of data block.  The data extracted by the receiver
//   is in the same order that it was transmitted. 
module bus_xfr_data_integrity_check (input clk,

    input wr_33, // Transmitter write signal @33MHz
    input rd_25,  // Receiver   read signal @25 MHz
    input int wdata, // write data from Transmitter
    input int rdata, // read data from Receiver
    input reset_n, // active low reset
    input clk_xt33,   // clock transmitter @33 MHz
    input clk_rcv25); // clock Receiver @25 MHz
  timeunit 1ns;
  timeprecision 100ps;
  parameter MAX_BUFF_SIZE=1024; 
  int waddr;  // write address for storage of incoming data
  int raddr;  // read address for reading of received data
  int rdata_from_q; // read data from queue to compare to Receiver
  int dataQ [$]; // queue, to store/read incoming data
  int dataQsize; // queue size. 
   //  int dataQ [$:1024]; // queue, to store/read incoming data, restricted to 1K 
  assign dataQsize= dataQ.size;  // for use with assertions and 1800-2009 style

  // Storage of data into queue
  always @ (posedge clk_xt33)
    if (reset_n==1'b0)
      dataQ = {1}; // clear the queue contents
    else  if (wr_33) dataQ.push_front(wdata);  // store data
  // Collect data from the Q 
  always @ (posedge clk_rcv25)
    if (rd_25)  rdata_from_q <= dataQ.pop_back();

  // Data integrity check 
  property p_read_data_integrity; 
    @(posedge clk_rcv25)
      rd_25 |=>  rdata_from_q==rdata;
  endproperty : p_read_data_integrity
  ap_read_data_integrity : assert property (p_read_data_integrity);

  // Never a READ with no data received
  property p_never_read_on_empty;
    @(posedge clk_rcv25)
      // not (dataQsize == 0 && rd_25); // Poor style 
      (dataQsize == 0) |-> !rd_25;   
  endproperty : p_never_read_on_empty
  ap_never_read_on_empty : assert property (p_never_read_on_empty);

  // never a write on a full buffer 
  property p_write_on_max_buff;
    @(posedge clk_xt33)
      not (dataQsize == MAX_BUFF_SIZE && wr_33);
  endproperty : p_write_on_max_buff
  ap_write_on_max_buff : assert property (p_write_on_max_buff);
endmodule : bus_xfr_data_integrity_check
