
module d20(input clk,reset_n,address,vaddress,retire); 
 // reg clk,reset_n,address,vaddress,retire;
reg cache[20];
reg VALID;
reg INVALID;property pValidRetire; 
  int vaddress;
  @ (posedge clk) disable iff (!reset_n) 
    ($rose(address) && cache[address]==VALID, vaddress= address) |-> 
                     (##[0:$] retire==vaddress ##[2:7] cache[vaddress]==INVALID);
endproperty : pValidRetire
endmodule :d20
