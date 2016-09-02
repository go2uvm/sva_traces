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
module memory_data_integrity_check (
    input bit write, // memory write
    input bit read,  // memory read
    input bit[31:0] wdata, // data written to memory
    input bit[31:0]  addr,  // memory address -- small for simulation 
    input bit reset_n, // active low reset
    input bit clk);   // clock 

    timeunit 1ns;   timeprecision 100ps;
    default clocking cb_clk @ (posedge clk);  endclocking 
    int mem_aarray[*]; // associative array (AA) to be used by property
    bit [31:0] rdata;  // data read from memory
    bit  mem_aarray_exists;  // exists at specified address
    assign mem_aarray_exists  = mem_aarray.exists(addr); 
    always_comb 
        if(mem_aarray_exists) 
            rdata  = mem_aarray[addr];  //  
    always@ (posedge clk)
        if (reset_n==1'b0) mem_aarray.delete; // Clears AA elements
        else if (write) mem_aarray[addr]  = wdata; // store data

    property p_read_after_write;
        bit [31:0] v_wrdata, v_wraddr;
        (write, v_wraddr=addr, v_wrdata= wdata) |-> // if write, save data and addr
        (read && mem_aarray_exists && addr==v_wraddr) [->1] |-> // @read and data there at same written addr
        rdata==v_wrdata;  // read data is same as what was written 
    endproperty : p_read_after_write
    ap_read_after_write : assert property (p_read_after_write)
        $info("addr =%h, rdata=%h", $sampled(addr), $sampled(rdata)); else 
        $error("addr =%h, rdata=%h", $sampled(addr), $sampled(rdata)); 
        
    property p_read_before_write;
        not (read && !mem_aarray_exists); // never a read on an non written address
    endproperty : p_read_before_write
    ap_read_before_write : assert property (p_read_before_write);
endmodule : memory_data_integrity_check

class c_xactn;
    rand bit write; // memory write
    rand bit read;  // memory read
    rand int wdata; // data written to memory
    rand bit[31:0] addr;  // memory address 
    constraint addr_range_cst { addr <= 15 ;}
    constraint no_wr_and_rd_cst { !(read && write);}
endclass : c_xactn
module top(
        input write,
    input read, 
    input int wdata,
     input int rdata, 
    input[31:0] addr,  
    input reset_n=1'b1, 
    input clk=1'b1);   
    c_xactn c1=new(); 
    memory_data_integrity_check mem_check1 (.*);

    //initial forever #50 clk=!clk;

   endmodule : top 
// vlog -mfcu memory_data_integrity_check.sv
// vsim -novopt -assertdebug top

