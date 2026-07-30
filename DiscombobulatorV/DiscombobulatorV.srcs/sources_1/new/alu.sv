module alu(
    input logic [31:0] in0,
    input logic [31:0] in1,
    input logic [2:0] sel,
    output logic [31:0] out
    );
    
always_comb begin
    case(sel)
        3'b000: out = in0 + in1;
        3'b001: out = in0 - in1;
        3'b101: out = ($signed(in0) < $signed(in1)) ? 32'd1 : 32'd0;
        3'b011: out = in0 | in1;
        3'b010: out = in0 & in1;
        default: out = 32'bx;
    endcase
end
   
endmodule
