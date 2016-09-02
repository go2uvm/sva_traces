class E #(type T = int); //  extends C;
    T x;
    function new(T x_init);
        // super.new();
        x = x_init;
    endfunction
endclass

//class vector #(parameter width = 7, type T = int);
//endclass
//vector #(3) v = new;
//initial $display (vector #(3)::T'(3.45)); // Typecasting
//initial $display ((v.T)'(3.45)); //ILLEGAL
//initial $display (v.width);
//initial begin
//    c = E #(.T(byte))::new(.x_init(5));

class C #(parameter width);
    task automatic t(bit [width:0] my_bit); //question, how to pass in a different width for each instance of the task
        $display(" pram=%d, bit value is %h", width, my_bit);
    endtask

endclass : C 

module m_task(input clk,input [19:0] a=20'b10000000000000000001,input [16:0] b=17'b10000000000000001);
  //  bit[19:0] a=20'b10000000000000000001; 
   // bit[16:0] b=17'b10000000000000001; 
 //   bit clk; 
    C #(20) c20=new(); 
    C #(17) c17=new(); 
        ap_a0_OK0: assert property (@(posedge clk)a==0 || a==1) else $display("fail:: a %d", a); 
    ap_a0_OK1: assert property (@(posedge clk)a==0 || a==1) else begin $display("fail:: a %d", a); end
 //   a_a0_OK:  assert #0 (a==0 || a==1 else $display("fail:: a %d", a);
     //  a_a0_ERR: assert #0 (a==0 || a==1 else begin $display("fail:: a %d", a); end

//        task automatic t(bit [width:0] my_bit); 
//            $display(" bit value is %d",my_bit);
//        endtask
//
    initial begin
        c20.t(a); // print a, it's a 20 bit bit
        c17.t(b); // print b, it's a 16 bit bit
    end
endmodule
