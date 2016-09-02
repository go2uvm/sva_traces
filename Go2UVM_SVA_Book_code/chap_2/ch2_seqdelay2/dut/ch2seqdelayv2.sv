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
module ch2seqdelay(input clk=0, read=0, go=0, a=0, b=0, c=0,
    
    input int   max_range);
 `define true 1'b1


    // a ##[1:max_delay] c 
//    property p_seq_with_var_delay(max_count);  // 1 or greater                               
//        int v_cnt;
//        @(posedge clk)
//            (a, v_cnt=0)  |->  first_match((`true, v_cnt=v_cnt+1)[*1:$] ##1 (
//            v_cnt == max_count))  |->  c;    
//    endproperty : p_seq_with_var_delay
    property p_seq_with_var_delay(max_count);  // 1 or greater                               
        int v_cnt;
        @(posedge clk)
            (a, v_cnt=0)  |=>  c within  first_match((`true, v_cnt=v_cnt+1)[*1:$] ##0  
            (v_cnt == max_count)) ;        
    endproperty : p_seq_with_var_delay
    ap_seq_with_var_delay : assert property (p_seq_with_var_delay(max_range));

    property check_resp_delay (start_cond, end_cond, rt_del);
        int v_del;
        @(posedge clk) (start_cond, v_del = 0) |->
            (!end_cond && v_del <= rt_del, v_del += 1) [*1:$]
            ##1 (end_cond && v_del <= rt_del);
    endproperty : check_resp_delay

    a_check_resp_delay : assert property (check_resp_delay (a,c,max_range))
        $info ("%0t end_cond asserted within %0d cycles of start_cond",
        $time, max_range);
    else
        $error ("%0t end_cond not asserted within %0d cycles of start_cond",
        $time,  max_range);

  `ifdef SVA_09
    property p_until_ex (start_cond, end_cond, rt_del);
        int v_del;
        @(posedge clk) (start_cond, v_del = 0) |->
            (v_del <= rt_del, v_del += 1) until_with end_cond;
    endproperty : p_until_ex
  `endif // SVA_09

    // CVC why negedge? default clocking @(negedge clk); 
    default clocking @(posedge clk); 
    endclocking


    property p_prop_with_arg(arg_count);  // 1 or greater                              @(posedge clk)
        a |=> (1'b1, sva_disp(arg_count)); 
    endproperty : p_prop_with_arg
    ap_prop_with_arg : assert property (p_prop_with_arg (max_range));

    function void sva_disp (int count_val);
        $display ("%0t %m count_val: %0d", $time, count_val);
    endfunction : sva_disp

   endmodule : ch2seqdelay

