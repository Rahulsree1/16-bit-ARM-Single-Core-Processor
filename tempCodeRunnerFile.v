module mux21(A,B,s,out);
    input [15:0] A,B;
    input [0:0]s;

    output [15:0] out;

    wire [15:0]mo;

    assign out = (s == 1'b0) ? B : A;



endmodule