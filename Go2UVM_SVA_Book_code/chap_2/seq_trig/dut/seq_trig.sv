module seq_trig(input clk, a=1,b=1,c=1,d=1,e,w,r,x,y,read,write,parity_error,int data, data1,data2,address);
    //bit clk, a=1'b1, b=1'b1, c=1'b1, d=1'b1, w, r, x, y, e; 
    //bit parity_error; 
    //int data, data1, data2, address; 
        `define true 1'b1 

    sequence q_memory_write_read (
        local input   int lv_a, 
        local output int lv_d);  
        @ (posedge clk) 
            (write, lv_a=address, lv_d=data) ##[1:$] read && address==lv_a && 
            data==lv_d;
    endsequence : q_memory_write_read

   /* property p_mem_parity; 
        int v_a, v_d; 
        @ (posedge clk)
            // Methods triggered or matched can not be applied to an instance 
            // of a sequence with input or inout local var formals.
           // q_memory_write_read(v_a, v_d).triggered |=> !parity_error;  // 
    endproperty : p_mem_parity*/
   // ap_mem_parity : assert property(@ (posedge clk) p_mem_parity);
   //Invalid property 'p_mem_parity' definition. 

endmodule : seq_trig
