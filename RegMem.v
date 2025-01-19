module RegMem(A1, A2, A3, WD, WE, RD1, RD2, clk, rst);
    input [2:0] A1,A2,A3;
    input [15:0] WD;
    input clk,rst,WE;

    output [15:0] RD1, RD2;

    //Memory
    reg [15:0] Registers [7:0];

    //Read
    assign RD1 = (!rst) ? 16'b0000000000000000 : Registers[A1];
    assign RD2 = (!rst) ? 16'b0000000000000000 : Registers[A2];

    always @(posedge clk) 
    begin
        if (WE) 
        begin
            Registers[A3] <= WD;
        end
    end

    initial begin
        Registers[3'b111] = 16'b0000000000000001;

        Registers[3'b110] = 90;

        Registers[3'b001] = 20;
        Registers[3'b010] = 20;


    end

endmodule


