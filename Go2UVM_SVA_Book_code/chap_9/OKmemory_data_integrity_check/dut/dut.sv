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
module memory_data_integrity_check (input clk,input write,input read,  // memory read
    input [31:0] wdata, // data written to memory
    input [31:0] rdata,  // data read from memory
    input [31:0]  addr,  // memory address -- small for simulation 
    input  reset_n, // active low reset
    );   // clock 

    timeunit 1ns;   timeprecision 100ps;
    default clocking cb_clk @ (posedge clk);  endclocking 
    int mem_aarray[*]; // associative array (AA) to be used by property
    bit [31:0] r_aadata;  // data read from memory
    bit  mem_aarray_exists;  // exists at specified address
    int twice_write=0; 
    function automatic void inc_twice_write(bit wr);
        if(wr) twice_write=twice_write+1;
    endfunction : inc_twice_write
    assign mem_aarray_exists  = mem_aarray.exists(addr); 
    always_comb 
        if(mem_aarray_exists) 
            r_aadata  = mem_aarray[addr];  //  not used 
    always@ (posedge clk)
        if (reset_n==1'b0) mem_aarray.delete; // Clears AA elements
        else if (write) mem_aarray[addr]  = wdata; // store data

    property p_read_after_write;  // Does not work on multiple writes before a read
        bit [31:0] v_wrdata, v_wraddr;
        (write, v_wraddr=addr, v_wrdata= wdata) |->  
        (read && mem_aarray_exists && addr==v_wraddr) [->1] |=> // @read and data there at same written addr
        rdata==v_wrdata;  // read data is same as what was written 
    endproperty : p_read_after_write
    ap_read_after_write : assert property (p_read_after_write)
        $info("addr =%h, rdata=%h", $past(addr), $past(rdata)); else 
        $error("addr =%h, rdata=%h", $past(addr), $past(rdata)); 
        
    property p_read_after_no_multiple_writes;
        bit [31:0] v_wrdata, v_wraddr;
        (write, v_wraddr=addr, v_wrdata= wdata) |-> // if write, save data and addr
        first_match (
           ((read && mem_aarray_exists && addr==v_wraddr) [->1])
          // @read and data there at same written addr
           or 
           (##1 (write && mem_aarray_exists && v_wraddr==addr)[->1])) |-> 
           // read data is same as what was written 
           // Accept if another writes to same same written addr
          (##1 rdata==v_wrdata)  or (##1 $past(write));  
    endproperty : p_read_after_no_multiple_writes
    ap_read_after_no_multiple_writes: assert property(p_read_after_no_multiple_writes)
         inc_twice_write($past(write)); // count # multiple writes before a read
    
     // never a read on an non written address
    ap_read_before_write : assert property (not (read && !mem_aarray_exists));
endmodule : memory_data_integrity_check

class c_xactn;
    rand bit write; // memory write
    rand bit read;  // memory read
    rand int wdata; // data written to memory
    rand bit[31:0] addr;  // memory address 
    constraint addr_range_cst { addr <= 8 ;}
    constraint no_wr_and_rd_cst { !(read && write);}
endclass : c_xactn
module top;
    timeunit 1ns;   timeprecision 100ps;
    bit write; // memory write
    bit read;  // memory read
    int wdata; // data written to memory
    int rdata; // data read from memory
    bit[31:0] addr;  // memory address 
    bit[31:0] [31:0] memory; // use small size for test 
      // bit[2**31:0] [31:0] memory;
    bit reset_n=1'b1; // active low reset
    bit clk=1'b1;   // clock
    c_xactn c1=new(); 
    memory_data_integrity_check mem_check1 (.*);

    initial forever #50 clk=!clk;
    
    always_ff @ (posedge clk) begin
        if(write) memory[addr] <= wdata; 
        if(read) rdata <= memory[addr];       
    end

    always_ff @ (posedge clk) begin 
        if(!c1.randomize())  $error("c1 randomization failure"); 
        write <= c1.write; 
        read  <= c1.read; 
        wdata <= c1.wdata;  
        addr  <= c1.addr; 
    end 
endmodule : top 
// vlog -mfcu OKmemory_data_integrity_check.sv
// vsim -novopt -assertdebug top

