module v9_8(input clk, gx_start, data_last );
   // bit clk, gx_start, data_last;
    int size=3; 
    typedef enum {READ, WRITE } rd_wr_e;
    rd_wr_e cmd; 
   // initial forever #10 clk=!clk; 
    //default clocking cb_clk @ (posedge clk);  endclocking 

    // Int v_start, size;  // why 32 bit int versus reg [2:0]


    property pWriteNstart;
        int v_start, target_size; 
        ($rose(cmd==WRITE), v_start=0, target_size=size)     
        |=>first_match( 
        (##[0:$] (gx_start, v_start=v_start+1))[*1:$] ##0  v_start==target_size
        )  |->  data_last;     
    endproperty : pWriteNstart
    apWriteNstart: assert property(@(posedge clk)pWriteNstart) else $error("apWriteNstart");

//    ap_error: assert property(   
//      $rose(cmd==WRITE)   // Range must be bounded by constant expressions.
//                     |=>( gx_start[-> size] ##1  data_last));

    ap_OK: assert property( @(posedge clk)  
        $rose(cmd==WRITE) 
        |=>( gx_start[->3] ##0  data_last));


endmodule : v9_8
