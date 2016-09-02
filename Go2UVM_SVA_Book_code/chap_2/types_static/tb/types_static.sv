/*virtual class C_virtual; // An object of an abstract class shall not be constructed directly
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
endclass : C_bfm*/

module types_static1;
   logic  clk,addr,data; 
    int i,k; 
   
types_static dut(.*); 
    default clocking cb_clk @ (posedge clk); endclocking 
        initial forever #10 clk=!clk; 
   
endmodule : types_static1

