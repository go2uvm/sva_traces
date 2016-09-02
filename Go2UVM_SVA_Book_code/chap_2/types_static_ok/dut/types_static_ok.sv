virtual class C_virtual; // An object of an abstract class shall not be constructed directly
    static int i=7, j=0; 
    static logic a=1, b;
endclass : C_virtual

class C2 extends C_virtual;  
    int k=5;  
endclass : C2

class C_bfm;
    static int size=10; 
    static bit is_master; 
    rand int data; 
    int addr; 
endclass : C_bfm

module types_static(input clk);
    //bit  clk; 
    int i=5; int k=5;  
 
   C_bfm c_bfm; 
    C2 c2;   
 initial begin
        repeat(5) @ (posedge clk); 
        c2=new();
    end

       ap_master: assert property(@(posedge clk)c_bfm.is_master && c_bfm.size >5);
    ap_C: assert property(@(posedge clk)c2.a |-> c2.i==i);

    //ap_illegal: assert property(@(posedge clk)c_bfm.data==0);  // Illegal reference to class "c_bfm".
  // ap_illegal2: assert property(@(posedge clk)c_bfm.addr==0); // Illegal reference to class "c_bfm".
  // ap_illegal3: assert property(@(posedge clk)c2.k==5); // Illegal reference to class "c2".

endmodule : types_static

