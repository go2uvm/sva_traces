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
module ch2_formal(input clk, go, request, rdy, read, write, parity,input int address,data);
    timeunit 1ns;
    timeprecision 1ns;
   
    sequence q_memory_write (
        local output int lv_address, 
        local output int lv_data, 
        local output logic lv_parity, 
        logic mem_write); // typed argument
        (mem_write, lv_address=address,     // if memory write then store into local variables
        lv_data=data,                //                                          address and data  
        lv_parity=^data);           //                                           computed parity
    endsequence : q_memory_write

    property p_mem_write_read (mem_read, mem_write);
        int v_address, v_data;
        logic v_parity;
        @ (posedge clk)
            $rose(go) |=> request  ##[1:5] rdy 
            ##0 q_memory_write(v_address, v_data, v_parity, write) 
            ##[1:$] mem_read && address==v_address 
            ##1 data==v_data && parity==v_parity;
    endproperty : p_mem_write_read
    a1 : assert property (p_mem_write_read(read, write));

endmodule : ch2_formal

