module hazardUnit(
    input logic [19:15] rs1E,
    input logic [24:20] rs2E,
    input logic [11:7] rdM,
    input logic [11:7] rdW,
    input logic regWriteM,
    input logic regWriteW,
    output logic [1:0] forwardAE,
    output logic [1:0] forwardBE
    );
    
always_comb begin
    if(((rs1E == rdM) & regWriteM) & (rs1E != 0))
        forwardAE = 2'b10; //forward from Mem Stage
    else if (((rs1E == rdW) & regWriteW) & rs1E != 0)
        forwardAE = 2'b01; //forward from WB stage
    else forwardAE = 2'b00; //no forward
    
    if(((rs2E == rdM) & regWriteM) & (rs2E != 0))
        forwardBE = 2'b10; //forward from Mem Stage
    else if (((rs2E == rdW) & regWriteW) & rs2E != 0)
        forwardBE = 2'b01; //forward from WB stage
    else forwardBE = 2'b00; //no forward
end
    
endmodule
