`include "./MUX.v"

module alu(A, B, aluControl, aluout, z,n,v,c);
    // Inputs
    input [15:0] A, B;
    input [2:0] aluControl;

    // Output
    output [15:0] aluout;
    output z,n,v,c;

    // Wires
    wire [15:0] aNb;       // A and B
    wire [15:0] aRb;       // A or B
    wire [15:0] nB;        // ~B
    wire [15:0] mux_1;     // Output of mux21
    wire [15:0] sum;
    wire [15:0] AxorB;
    wire [0:0] cout;      // Sum calculation

    // Logic
    assign aNb = A & B;
    assign aRb = A | B;
    assign nB = ~B;
    assign AxorB = A ^ B;

    // Instantiate mux21 module
    mux21 uut (
        .A(B), 
        .B(nB), 
        .s(aluControl[0]), 
        .out(mux_1)
    );

    assign {cout,sum} = A + mux_1 + aluControl[0];

    // Instantiate mux41 module
    mux81 utt1 (
        .I0(sum),
        .I1(sum),
        .I2(aNb),
        .I3(aRb),
        .I4(nB),
        .I5(AxorB),
        .s(aluControl),
        .out(aluout)
    );

    // flags

    assign z = &(~aluout);
    assign n = aluout[15];
    assign c = cout & (~aluControl[1]);
    assign v = (~aluControl[1]) & (A[15] ^ sum[15]) & (~(A[15] ^ B[15] ^ aluControl[0]));



endmodule
