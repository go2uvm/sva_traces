 module m (input clk,rst);
reg a;
time clk_period = 20ns; 
    property p_period ( int clk_period);
        time current_time; 
        disable iff (rst)
        ('1, current_time = $time) |=> (clk_period == ($time - current_time) );
    endproperty : p_period
    ap_period: assert property(@ (posedge clk) p_period(clk_period));
endmodule: m
