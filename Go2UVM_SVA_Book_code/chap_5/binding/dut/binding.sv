//module binding;
// endmodule : binding
module unit_chk(input clk, input x, y, a, b);   // compiled separately 
 always @ (posedge clk) begin
     $display("x=%b, y=%b, a=%b, b=%b", x, y, a, b); 
 end
endmodule : unit_chk

module dut(input bit clk, a, b); 
   bit x, y=1; 
   always @ (posedge clk) begin
       x<=!x; 
       y<=!a; 
   end
endmodule : dut 

module top(input clk);
bit clk_top, a, b, c1, d1;
  
  int   r1;
  dut dut1(.clk(clk_top), .*);  // dut instantiation 

// checker binding to DUT 
    //bind dut unit_chk my_checker1 (clk, x, y, a , b); // connects to DUT signals 
 endmodule : top

bind dut2 unit_chk my_checker1 (clk, x, y, a , b); // connects to DUT signals 
module dut2(input bit clk, a, b); 
   bit x, y=1; 
   always @ (posedge clk) begin
       x<=!x; 
       y<=!a; 
   end
endmodule : dut2 
// To compile in QuestaSim: 
// vlog -cuname bind_pkg -mfcu binding.sv
// To simulate with debug 
// vsim -novopt -assertdebug dut2 bind_pkg
