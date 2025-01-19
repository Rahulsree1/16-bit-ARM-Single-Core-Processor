`include "./Main.v"

`timescale 1ns/1ps

module main_tb;

    // Testbench signals
    reg clk, rst;             // Clock and reset inputs
    wire [4:0] pcWire;        // Program counter wire
    wire [15:0] out;          // Instruction memory output wire

    // Instantiate the main module
    main uut (
        .clk(clk),
        .rst(rst)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Toggle clock every 5 time units
    end

    // Test sequence
    initial begin
        // Initialize reset
        rst = 0;

        // Open VCD file for GTKWave
        $dumpfile("main_tb.vcd"); // VCD file name
        $dumpvars(0, main_tb);    // Dump all variables in the current module

        // Display header for simulation
        // $display("Time\tClk\tRst\tPC\tInstruction");
        // $monitor("%0t\t%b\t%b\t%b\t%h", $time, clk, rst, pcWire, out);

        // Test 1: Reset the system
        #10 rst =   1; // Deactivate reset

        // Test 2: Let the PC increment
        #150; // Wait for a few clock cycles to observe behavior

        // Test 3: Additional reset
        #10 rst = 0;
        #10 rst = 1;

        // End the simulation
        #50 $finish;
    end

endmodule
