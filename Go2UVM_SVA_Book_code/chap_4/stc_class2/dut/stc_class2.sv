class  ID;
    static int id = 0;
    static function int get_id();
        return id; 
    endfunction

    static function int set_id(int d);
        id=d; 
    endfunction
endclass

module mx;
    ID id2;  
    initial begin
        id2.set_id(50); 
    end

endmodule : mx

module mz;
    ID id1; 
    int my_id; 
    initial begin
        #10 my_id=id1.get_id(); 
        #50 $display("my id1= %d", my_id); 
    end

endmodule : mz

module tp1(input clk);
    mx mx1(); 
    mz mz1(); 

endmodule : tp1
