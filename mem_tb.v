`include "./Memory.v"

module tb_Memory;

    // Testbench signals
    reg [4:0] adr;       // Address bus
    reg [15:0] WD;       // Write data
    reg clk, WE;         // Clock and write-enable signals
    wire [15:0] Memout;  // Output from the memory

    // Instantiate the Memory module
    Memory uut (
        .adr(adr),
        .WD(WD),
        .clk(clk),
        .WE(WE),
        .Memout(Memout)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10-unit time period clock
    end

    // Test sequence
    initial begin
        $dumpfile("mem_tb.vcd"); // Name of the VCD file
        $dumpvars(0, tb_Memory);    // Record all variables in the mux_tb module
        // Initialize inputs
        adr = 5'b00000;  // Address 0
        WD = 16'h0000;   // Data to write
        WE = 1'b0;       // Initially set write enable to 0 (read mode)

        // Display a header for the test
        $display("Time\tClk\tWE\tAdr\tWD\tMemout");
        $monitor("%0t\t%b\t%b\t%b\t%h\t%h", $time, clk, WE, adr, WD, Memout);

        // Test 1: Write data to address 0
        #10 WE = 1'b1; adr = 5'b00000; WD = 16'hA5A5; // Write 0xA5A5 to address 0
        #10 WE = 1'b0; // Stop writing

        // Test 2: Write data to address 1
        #10 WE = 1'b1; adr = 5'b00001; WD = 16'h5A5A; // Write 0x5A5A to address 1
        #10 WE = 1'b0; // Stop writing

        // Test 3: Read data from address 0
        #10 adr = 5'b00000; // Set address to 0 (read mode)

        // Test 4: Read data from address 1
        #10 adr = 5'b00001; // Set address to 1 (read mode)

        // Test 5: Invalid read (write enable remains 1)
        #10 WE = 1'b1; adr = 5'b00010; // Unexpected behavior test

        #10 $finish; // End the simulation
    end

endmodule
