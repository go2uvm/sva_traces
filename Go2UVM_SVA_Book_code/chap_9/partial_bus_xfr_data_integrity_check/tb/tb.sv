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
module top1 (input clk,
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

default clocking cb @(posedge clk);
endclocking
 bus_xfr_data_integrity_check dut (.*);

   // Storage of data into queue
 endmodule :top1 
