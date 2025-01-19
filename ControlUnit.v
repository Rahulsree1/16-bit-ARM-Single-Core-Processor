module ControlUnit(op,Regw, memW, ResSrc, aluSrc, aluOP, pcSrc, branch);
    input [1:0] op;

    output Regw, memW, ResSrc, aluSrc, pcSrc,branch;
    output [1:0] aluOP;

    wire branch;

    assign Regw = ((op == 2'b00) | (op == 2'b01)) ? 1'b1 : 1'b0;

    assign memW = (op == 2'b11) ? 1'b1 : 1'b0;

    assign aluSrc = ((op == 2'b11) | (op == 2'b01)) ? 1'b1 : 1'b0;

    assign aluOP = ((op == 2'b01) | (op == 2'b11)) ? 2'b00 : (op == 2'b10) ? 2'b01 : 2'b10;

    assign ResSrc = ((op == 2'b11) | (op == 2'b01)) ? 1'b1 : 1'b0;

    assign branch = (op == 2'b10) ? 1'b1 : 1'b0;
    
  
endmodule



