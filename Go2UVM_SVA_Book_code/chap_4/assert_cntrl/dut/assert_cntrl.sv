module assert_cntrl(
    input  a, b, c,  w, clk, output d, 
    input  [3:0] v=4'b1010); 
    reg d;
 //   rand a,b,v;
    
	ap_1b: assert property(@(posedge clk)a |=> b) 
        begin  
            $display("Message: pass, assigning 1’b1 to d"); 
             d <= 1'b1; 
        end 
        else $error("Message: fail a b ");  

ap_v: assert property(@(posedge clk)v==4'b0000 |=> a) $display("ap_v"); else $error("error ap_v");
//initial begin
 //repeat (10) 
 //       #10  if(!randomize(a, b, v))  $error("randomization failure"); 
  //  end

ap_vac: assert property(@(posedge clk)w |-> a) $display("vac"); else $error("ap_vac");

initial $assertpasson(0);



endmodule : assert_cntrl
