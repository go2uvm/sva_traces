class c;
    static int size=10; 
    static bit is_master; 
   // rand int data; 
   // int addr; 
endclass : c
typedef enum {BK_RED , BK_GREEN, BK_BLUE } colors_e;

module types(input clk,a,b,rd,read,  input logic [31:0]rdata,input logic[31:0]wdata,foo,bar, input logic [3:0]addr);
  
     int data; 
  colors_e color;
    c c1;
   // bit clk, a, b, rd; 
    
    real r=2.1, y=10.0; 
    string s="hello", g="hello"; 
    realtime rtime;
    time t;  
    int mem_aarray[*]; // associative array (AA) to be used by property
   // logic [31:0] rdata;  // data read from memory
    //logic read;  // memory read
    //logic[31:0] wdata, foo, bar; // data written to memory
   // logic[3:0]  addr;  // memory address -- small for simulation */
   ap_real: assert property(@(posedge clk)r==y);
    ap_rtime: assert property(@(posedge clk)rtime > 10.2 );
    ap_time: assert property(@(posedge clk)t > 10ns);
    ap_data: assert property(@(posedge clk)rdata ==32'hFFFF0000);
    ap_colors: assert property(@(posedge clk)color==BK_BLUE);
    // ap_string: assert property(s==g);

    int dataQ [$]; // queue, to store/read incoming data
// Never a READ with no data received
 int dataQsize; // queue size.
    assign dataQsize= dataQ.size; 
    property p_never_read_on_empty;
        not (dataQsize == 0 && rd); 
    endproperty : p_never_read_on_empty
    ap_never_read_on_empty: assert property(@(posedge clk)p_never_read_on_empty);
// A solution is to declare a temporary place holder object of static data 
// type and use that inside the properties. 
// For the above example, the following can be expressed:
   // see Section 8.2.14 
    property p_never_read_on_emptyOK;
        not (dataQsize == 0 && rd); 
    endproperty : p_never_read_on_emptyOK
    ap_never_read_on_emptyOK: assert property(@(posedge clk)not (dataQsize == 0 && rd));

    property p_test;
        $rose(read) && addr==rdata |-> 1'b1; // rdata != 32'bx;
        // mem_aarray[addr]==rdata;  // illegal use of mem_aarray[addr]
    endproperty : p_test
    ap_test : assert property (@(posedge clk)addr==rdata);

   ap_master: assert property(@(posedge clk)c1.is_master && c1.size >5);
  ap_illegal: assert property(@(posedge clk)data==0);;
  ap_illegal2: assert property(@(posedge clk)addr==0);

    always @(posedge clk) begin : alw_foo
        logic k=1'b1;  // automatic 
        // variable declared in for statement is automatic 
        for (int i=0; i<10; i++) begin
            a4: assert property (@(posedge clk)foo[i] && bar[i]);
        end
    end : alw_foo

    ap_illegalfoo: assert property(@(posedge clk)alw_foo.k);
    // initial c1=new(); 

endmodule : types
