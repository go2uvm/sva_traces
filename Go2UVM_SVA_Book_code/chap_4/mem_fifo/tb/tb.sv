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
module top1; 
    timeunit 1ns; 
   timeprecision 1ns;
 logic wr_33; // Transmitter write signal @33MHz
 logic rd_25;  // Receiver   read signal @25 MHz
 logic[31:0]    wdata; // write data from Transmitter
 logic[31:0]    rdata; // read data from Receiver
 logic reset_n; // active low reset
 logic clk_xt33;   // clock transmitter @33 MHz
 logic clk_rcv25; // clock Receiver @25 MHz
  parameter MAX_BUFF_SIZE=1024; 
  logic[31:0] waddr;  // write address for storage of incoming data
  logic[31:0] raddr;  // read address for reading of received data
  logic[31:0] rdata_from_q; // read data from queue to compare to Receiver
  logic[31:0] dataQ ; // queue, to store/read incoming data
  logic[31:0] dataQsize; // queue size. 

bus_xfr_data_integrity_check dut ( 
                    .clk_rcv25(clk_rcv25),
                   .clk_xt33(clk_xt33),
                    .wr_33(wr_33),
                    .rd_25(rd_25),
                    .wdata(wdata),
                    .rdata(rdata),
                    .reset_n(reset_n),
		     .waddr(waddr),
                     .rdata_from_q(rdata_from_q),
		                         .dataQsize(dataQsize),
                     .raddr(raddr)				
                );
// default disable iff  (!reset_n);
    default clocking cb_clk @ (posedge clk_rcv25,clk_xt33);
    endclocking 
    

    
endmodule : top1
