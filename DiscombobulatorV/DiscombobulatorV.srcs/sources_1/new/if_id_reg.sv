module if_id_reg (
    input logic clk,
    input logic rst,
    input logic en,
    input logic clr,
    input logic [31:0] instrF,
    input logic [31:0] pcF,
    input logic [31:0] pcPlus4F,
    output logic [31:0] pcPlus4D,
    output logic [31:0] pcD,
    output logic [31:0] instrD
);

always_ff @(posedge clk, posedge rst)begin
    if(rst == 1 || clr == 1)begin
        pcPlus4D <= 0;
        pcD <= 0;
        instrD <= 0;
    end
    else if(en == 0)begin
        instrD <= instrF;
        pcD <= pcF;
        pcPlus4D <= pcPlus4F;
    end
end

endmodule