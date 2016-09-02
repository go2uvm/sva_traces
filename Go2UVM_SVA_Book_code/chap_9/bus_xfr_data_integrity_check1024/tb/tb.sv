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

module test1;
bus_xfr_data_integrity_check1024 dut (.*); 
    

        logic clk_xt33, clk_rcv25;
       logic wr_33; // Transmitter write signal @33MHz
    logic rd_25;  // Receiver   read signal @25 MHz
     int wdata; // write data from Transmitter
     int rdata; // read data from Receiver
    logic reset_n; // active low reset
    // clock Receiver @25 MHz
    parameter MAX_BUFF_SIZE=1024; 
    int waddr;  // write address for storage of incoming data
    int  raddr;  // read address for reading of received data
    int  rdata_from_q; // read data from queue to compare to Receiver
    int  dataQ [$:1024];  // queue, to store/read incoming data
    int  dataQ_size;


    default clocking @(negedge clk_xt33,clk_rcv25); endclocking
  
endmodule : test1

