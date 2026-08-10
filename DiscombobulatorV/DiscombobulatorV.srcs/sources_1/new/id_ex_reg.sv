module id_ex_reg (
    input logic clk,
    input logic rst,
    input logic regWriteD,
    input logic memWriteD,
    input logic jumpD,
    input logic branchD,
    input logic aluSrcD,
    input logic [1:0] resultSrcD,
    input logic [2:0] aluControlD,
    input logic pcD,
    input logic [31:0] rd1D,
    input logic [31:0] rd2D,
    input logic [11:7] rdD,
    input logic [31:0] immExtD,
    input logic [31:0] pcPlus4D,
    input logic [19:15] rs1D,
    input logic [24:20] rs2D,
    input logic clr,
    output logic [19:15] rs1E,
    output logic [24:20] rs2E,
    output logic pcE,
    output logic [31:0] rd1E,
    output logic [31:0] rd2E,
    output logic [11:7] rdE,
    output logic [31:0] immExtE,
    output logic [31:0] pcPlus4E,
    output logic regWriteE,
    output logic memWriteE,
    output logic jumpE,
    output logic branchE,
    output logic aluSrcE,
    output logic [1:0] resultSrcE,
    output logic [2:0] aluControlE
);

always_ff @(posedge clk, posedge rst) begin
    if(rst == 1 || clr == 1)
        begin
            regWriteE <= 0;
            memWriteE <= 0;
            jumpE <= 0;
            branchE <= 0;
            aluSrcE <= 0;
            resultSrcE <= 2'd0;
            aluControlE <= 3'd0;
            pcE <= 0;
            rdE <= 5'd0;
            immExtE <= 32'd0;
            pcPlus4E <= 32'd0;
            rd1E <= 32'd0;
            rd2E <= 32'd0;
            rs2E <= 5'd0;
            rs1E <= 5'd0;
        end
    else
        begin
            regWriteE <= regWriteD;
            memWriteE <= memWriteD;
            jumpE <= jumpD;
            branchE <= branchD;
            aluSrcE <= aluSrcD;
            resultSrcE <= resultSrcD;
            aluControlE <= aluControlD;
            pcE <= pcD;
            rdE <= rdD;
            immExtE <= immExtD;
            pcPlus4E <= pcPlus4D;
            rd1E <= rd1D;
            rd2E <= rd2D;
            rs2E <= rs2D;
            rs1E <= rs1D;
        end
end

endmodule