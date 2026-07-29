module aluDecoder(
    input logic op_b5,
    input logic [2:0] funct3,
    input logic funct7b5,
    input logic [1:0] aluOp,
    output logic [2:0] aluControl
);

logic RtypeSub;

assign RtypeSub = op_b5 & funct7b5; //true for rtype sub

always_comb begin
    case(aluOp)
        2'b00: aluControl = 3'b000; //add
        2'b01: aluControl = 3'b001; //sub
        2'b10: 
        begin
            case(funct3)
                3'b000: 
                begin
                    if(RtypeSub)
                        aluControl = 3'b001; //sub
                    else
                        aluControl = 3'b000; //add
                end
                3'b010: aluControl = 3'b101; //slt
                3'b110: aluControl = 3'b011; //or
                3'b111: aluControl = 3'b010; //and
                default: aluControl = 3'bxxx; //?
            endcase
        end
    endcase

end

endmodule