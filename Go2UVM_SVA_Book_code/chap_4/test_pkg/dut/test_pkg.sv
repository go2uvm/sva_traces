package pk; 
    logic a, b; 
    property P(a, b); a |=> b; endproperty : P
endpackage : pk 

module  k (input clk);
    import pk::*;
       ap1: assert property(@(posedge clk)pk::P(pk::a, pk::b));
endmodule : k 
