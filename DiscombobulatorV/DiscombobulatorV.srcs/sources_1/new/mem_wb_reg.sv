module mem_wb_reg (
    input logic clk,
    input logic rst,
    input logic regWriteM,
    input logic [1:0] resultSrcM,
    input logic [31:0] aluResultM,    
    input logic [31:0] readDataM,    
    input logic [11:7] rdM,  
    input logic [31:0] pcPlus4M,
    output logic [31:0] pcPlus4W,
    output logic [31:0] aluResultW,    
    output logic [11:7] rdW,    
    output logic [31:0] readDataW, 
    output logic regWriteW,
    output logic [1:0] resultSrcW
);

always_ff @(posedge clk, posedge rst) begin
    if (rst == 1)
        begin
            regWriteW <= 0;
            resultSrcW <= 2'd0;
            rdW <= 5'd0;
            aluResultW <= 32'd0;
            pcPlus4W <= 32'd0;
            readDataW <= 32'd0;
        end
    else    
        begin
            regWriteW <= regWriteM;
            resultSrcW <= resultSrcM;    
            rdW <= rdM;
            aluResultW <= aluResultM;
            pcPlus4W <= pcPlus4M;
            readDataW <= readDataM;       
        end
end

endmodule