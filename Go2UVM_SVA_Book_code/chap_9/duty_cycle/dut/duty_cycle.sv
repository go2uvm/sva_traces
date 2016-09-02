// ch9/duty_cycle.sv
//how to check for 50% duty cycle? (+/- 1) 
module duty_cycle(input clk,go);
reg temp; 
//	logic clk = 0, go; 
	time my_time; 
	

	always @(clk) my_time <=$time;

	time rise, fall; 
	integer duty; 
	
	ap_duty: assert property (@ (clk) (go) |-> (duty == 50)) else 
		$display($time, " Duty cycle error, duty = %0d", duty); 
	
	ap_duty0b: assert property (@ (clk) ($stime > 40ns) |-> (duty == 50)) else 
		$display($time, " Duty cycle error, duty = %0d", duty); 
		
	ap_duty0: assert property (@ (clk) (my_time > 40ns) |-> (duty == 50)) else 
		$display($time, " Duty cycle error, duty = %0d", duty); 
		
	ap_duty1: assert property (@ (clk) (duty == 50)) else 
		$display($time, " Duty cycle error, duty = %0d", duty); 
			
	always @(clk) begin 
		if (clk) rise <= $time; 
		else begin 
			fall <= $time; 
			duty = ($time - rise)*100/($time - fall); 
		end 
	end 
	
	initial begin
		repeat (4) @(clk); 
	temp <= 1'b1;
	assign temp=go; 	    
	end
	// initial #100 $finish; 
endmodule : duty_cycle
