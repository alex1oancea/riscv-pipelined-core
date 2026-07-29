module mainDecorder(
    input logic [6:0] op,
    output logic branch,
    output logic [1:0] resultSrc,
    output logic memWrite,
    output logic aluSrc,
    output logic jump,
    output logic [1:0] immSrc,
    output logic regWrite,
    output logic [1:0] aluOp
    );
    
    logic [10:0] controls;
    
    assign {regWrite, immSrc, aluSrc, memWrite, resultSrc, branch, aluOp, jump} = controls;
    
    always_comb begin
        case(op)  
            7'b0000011: controls = 11'b10010010000;//lw
            7'b0100011: controls = 11'b00111xx0000;//sw
            7'b0110011: controls = 11'b1xx00000100;//r-type
            7'b1100011: controls = 11'b01000xx1010;//beq
            7'b0010011: controls = 11'b10010000100;//i-type
            7'b1101111: controls = 11'b111x0100xx1;//jal
            default: controls = 11'bx;
        endcase
    end
    
endmodule
