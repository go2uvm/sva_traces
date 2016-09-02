typedef bit [31:0]  l32_type;  
typedef bit[16:0]   l16_type;  
module aa_array(input bit clk, reset_n, write, read,  
        input  l32_type addr,  
        input  l16_type wdata, rdata);
    l32_type asize; // aray size
    l16_type rdata_lc; // local rdata
    l16_type mem_array[l32_type]; // associative array  
    bit aa_exists;
    always_ff @ (posedge clk) begin 
        if (reset_n==1'b0) mem_array.delete; // Clears AA elements 
        else if (write) mem_array[addr] = wdata; // store data if write
        if(read && aa_exists) rdata_lc <= mem_array[addr];  // @clk, read if exists 
        asize <= mem_array.size;
        $display("mem_array.size =%d", mem_array.size); 
    end

    always_comb aa_exists=mem_array.exists(addr); 
    
    ap_mem_coherency: assert property(
        @ (posedge clk) 
        (aa_exists && read) |=> rdata_lc==rdata);
    ap_exists: assert property(@ (posedge clk)
          read |-> aa_exists);

endmodule :aa_array

module top_aa(input clk,reset_n,write,read ,    
input l32_type addr,
input l16_type wdata,output reg [16:0]rdata);
logic [2**16-1:0] [31:0] memory;
 

//bit[2**16-1:0] [31:0] memory;

        
        aa_array aa_array1(.*); 
    
    always_ff @ (posedge clk)  begin : aly 
        if(write) memory[addr] <= wdata; 
        if(read) rdata <= memory[addr]; 
    end  : aly

endmodule : top_aa
