module pcInc(a,b,c,s);
    input [4:0] a,b;
    input s;

    output [4:0] c;

    assign c = a + b; 

endmodule