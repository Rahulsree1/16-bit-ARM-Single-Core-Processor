`include "./PC.v"
`include "./IMem.v"
`include "./pcINC.v"
`include "./RegMem.v"
`include "./ControlUnit.v"
`include "./ALU.v"
`include "./aluDecoder.v"
`include "./Extender.v"
`include "./MUX.v"
`include "./Memory.v"
`include "./comparator.v"
`include "./Branch.v"
`include "./stack.v"





module main(clk, rst);

    input clk, rst;

    wire [4:0] pcWire, pII,pcNxt;
    wire [15:0] Ist;

    wire Rw, Mw, ResSrc, aluSrc, b;
    wire [1:0] aluop;

    wire [15:0] r1, r2, RWdatain;
    wire [2:0] alcontrol;

    wire [15:0] er2;

    wire [15:0] alumux;

    wire [15:0] aluout;

    wire [15:0] memout;

    wire [2:0] strmux;

    wire pflag, fcall;

    wire [4:0] pcmux;

    wire [4:0] stout;

    wire [4:0] stdatain;



    PC pc(
        .clk(clk),
        .rst(rst),
        .pcN(pcNxt),
        .pc(pcWire)
    );

    
    

    ControlUnit CU(
        .op(Ist[1:0]),
        .Regw(Rw),
        .memW(Mw),
        .ResSrc(ResSrc),
        .aluSrc(aluSrc),
        .branch(b), // Add appropriate connection if needed
        .aluOP(aluop),
        .pcSrc()  // Add appropriate connection if needed
    );

    //Ist[13:11]
    assign strmux = ((Mw == 1'b1) | b) ? Ist[7:5] : Ist[13:11];



    RegMem rm(
        .A1(Ist[10:8]), 
        .A2(strmux), 
        .A3(Ist[7:5]), 
        .WD(RWdatain), 
        .WE(Rw), 
        .RD1(r1), 
        .RD2(r2), 
        .clk(clk), 
        .rst(rst)
    );

    aluDecode ald(
        .func(Ist[4:2]), 
        .aluop(aluop), 
        .aluC(alcontrol)
    );

    Extender ext(
        .in(Ist[15:11]),
        .out(er2)
    );


    mux21 mux21alu(
        .A(r2),
        .B(er2),
        .s(aluSrc),
        .out(alumux)
    );



    alu al(
        .A(r1), 
        .B(alumux), 
        .aluControl(alcontrol), 
        .aluout(aluout), 
        .z(), 
        .n(), 
        .v(), 
        .c()
    );



    branch brnch(
        .A(r2), 
        .B(r1), 
        .pcflag(pflag), 
        .func(Ist[4:2]),
        .fcall(fcall),
        .fcallend(fcallend)
    );


    Memory memory(
        .adr(aluout[12:0]),
        .WD(r2), 
        .clk(clk), 
        .WE(Mw), 
        .Memout(memout)
    );


    mux21 resmux(
        .A(aluout),
        .B(memout),
        .s(ResSrc),
        .out(RWdatain)
    );


    assign pcmux = (b & pflag) ? Ist[15:11] : (Ist == 16'b1111111111111111) ? 5'b00000 : 5'd1;

    

    pcInc pcinc(
        .a(pcWire),
        .b(pcmux),
        .c(pII),
        .s()
    );

    assign stdatain = pcWire + 5'b00001;

    stack st(
        .clk(clk),
        .reset(rst),
        .push(fcall),
        .pop(fcallend),
        .data_in(stdatain),
        .data_out(stout)
    );

    // assign pcNxt = pII;

    assign pcNxt = (fcall == 1'b1) ? Ist[9:5] :
                    (fcallend == 1'b1) ? stout : pII;





    Imem imem(
        .adr(pcWire),
        .rst(rst),
        .Imaout(Ist)
    );



endmodule
