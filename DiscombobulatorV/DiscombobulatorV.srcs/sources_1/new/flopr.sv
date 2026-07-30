module flopr #(parameter size = 8)
(
    input logic [size-1:0] d,
    input logic clk, rst,
    output logic [size-1:0] q
);

always_ff @(posedge clk, posedge rst)begin
    if (rst == 1)
        q <= 0;
    else
        q <= d;
end

endmodule