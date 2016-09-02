module rand_gen (input  clk_ev, 
        output int data,  
        output bit select);
    //int data2; 
// data2 may assume values 3 and 5 only
   bit r;
    assign select = r; 
    let data2 = r ? 3'd3 : 3'd5; 
    ap_data: assume property (@ (clk_ev)
        data > 100 && data < 500); 
endmodule : rand_gen

module top(input clk); 
  //  bit clk;  
    int data, data2;  // signals driven randomly by checker 
    bit select;  // signal driven randomly by checker
    // ..
    rand_gen rand_gen1(clk, data,data2); 
    
    //dut dut1(.*); 
endmodule : top
    
