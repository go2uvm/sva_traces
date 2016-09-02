// reqack_rand.sv
// parameter SIZE=8

//checker wr_mem_rand (input event clk_ev, 
//        input bit wr, bkside, 
//        input bit[7:0] indata, bkdata);
//    rand const bit [7:0] vdata;
//    // if(wr) in_data is stored 
//    // and then this data is available 1 to cycles later at bkdata  
//    ap_wr_bk: assert property (@clk 
//        wr && in_data == vdata implies
//        ##[1:2] bkside && bkdata==vdata 
//        );
//endchecker : wr_mem_rand


//property p_wr_bk;
//    bit [7:0] vdata;
//    (wr,  vdata=in_data)  implies
//    ##[1:2] bkside && bkdata==vdata; 
//endproperty : p_wr_bk
module chk_count(input clk, input  a, b); 
reg [31:0] count;
    bit y;
    assign y=a && b; 

    always_ff @ (clk) begin : ff1
        static bit[31:0] v;
        if(b)  v+=1'b1; 
        count <= v; 
    end
endmodule : chk_count

/*checker chk_count(event clk_ev, input bit a, b, output bit[31:0] count);
    bit y;
    assign y=a && b; 

    always_ff @ (clk_ev) begin : ff1
        static bit[31:0] v;
        if(b)  v+=1'b1; 
        count <= v; 
    end
endchecker : chk_count*/
