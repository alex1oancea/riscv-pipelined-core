module ex_mem_reg(
    input logic clk,
    input logic rst,
    input logic regWriteE,
    input logic memWriteE,
    input logic [1:0] resultSrcE,
    input logic [31:0] aluResultE,
    input logic [31:0] writeDataE,
    input logic [31:0] pcPlus4E,
    input logic [11:7] rdE,
    output logic [11:7] rdM,
    output logic [31:0] pcPlus4M,
    output logic regWriteM,
    output logic memWriteM,
    output logic [1:0] resultSrcM,
    output logic [31:0] aluResultM,
    output logic [31:0] writeDataM
    );
    
always_ff @(posedge clk, posedge rst) begin
    if(rst == 1)
    begin
        regWriteM <= 0;
        memWriteM <= 0;
        resultSrcM <= 2'd0;
        rdM <= 5'd0;
        pcPlus4M <= 32'd0;
        aluResultM <= 32'd0;
        writeDataM <= 32'd0;
    end
    else
    begin
        regWriteM <= regWriteE;
        memWriteM <= memWriteE;
        resultSrcM <= resultSrcE;
        rdM <= rdE;
        pcPlus4M <= pcPlus4E;
        aluResultM <= aluResultE;
        writeDataM <= writeDataE;
    end
end
    
endmodule
