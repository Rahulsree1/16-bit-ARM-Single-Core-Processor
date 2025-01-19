module comparator(A, B, lt, gt, eq);
    input [15:0] A, B;


    output lt, gt, eq;



    assign lt = (A < B) ? 1'b1 : 1'b0;  
    assign gt = (A > B) ? 1'b1 : 1'b0;  
    assign eq = (A == B) ? 1'b1 : 1'b0; 
endmodule
