`timescale 1ns/1ps
`include "./ALU.v"


module mux_tb;

    // Declare inputs as reg and outputs as wire
    reg [15:0] A, B;
    reg [2:0] s;
    wire [15:0] out;

    // Instantiate the mux21 module with an instance name
    alu uut (
        .A(A), 
        .B(B), 
        .aluControl(s), 
        .aluout(out)
    );

    // Testbench logic
    initial begin
        // Generate the VCD file
        $dumpfile("mux_tb.vcd"); // Name of the VCD file
        $dumpvars(0, mux_tb);    // Record all variables in the mux_tb module

        // Test case 1: Select B (s=0)
        A = -15; // Example value for A
        B = -12; // Example value for B
        s = 000;
        #10;          // Wait 10 time units

        // Test case 2: Select A (s=1)
        s = 100;       // Select input
        A = 10'd9; // Example value for A
        B = 10'd8; // Example value for B

        #10; // Wait 10 time units

        // Finish simulation
        $finish;
    end

endmodule
