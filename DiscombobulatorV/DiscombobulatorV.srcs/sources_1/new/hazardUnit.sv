module hazardUnit(
    input logic [19:15] rs1E,
    input logic [19:15] rs1D,
    input logic [24:20] rs2E,
    input logic [24:20] rs2D,
    input logic [11:7] rdM,
    input logic [11:7] rdE,
    input logic [11:7] rdW,
    input logic regWriteM,
    input logic regWriteW,
    input logic resultSrcE,
    input logic pcSrcE,
    output logic [1:0] forwardAE,
    output logic [1:0] forwardBE,
    output logic stallF,
    output logic stallD,
    output logic flushE,
    output logic flushD
    );

logic lwStall;
    
always_comb begin
    //forward logic
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
    
    //stall logic
    lwStall = resultSrcE &L ((rs1D == rdE) | (rs2D == rdE));
    stallF = lwStall;
    stallD = lwStall;
    flushE = lwStall | pcSrcE;
    flushD = pcSrcE;
end
    
endmodule
