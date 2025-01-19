`ifndef MUX_V  // Check if MUX_V is not defined
`define MUX_V  // Define MUX_V to prevent re-inclusion

module mux21(A,B,s,out);
    input [15:0] A,B;
    input [0:0]s;

    output [15:0] out;

    assign out = (s == 1'b0) ? A : B;

endmodule


module mux81(I0,I1,I2,I3,I4,I5,s,out);

    input [15:0] I0,I1,I2,I3,I4,I5;
    input [2:0] s;

    output [15:0] out;


    assign out = (s == 3'b000) ? I0:
                 (s == 3'b001) ? I1:
                 (s == 3'b010) ? I2:
                 (s == 3'b011) ? I3:
                 (s == 3'b100) ? I4 : I5;


endmodule

`endif // End of MUX_V guard