module flopr #(parameter size = 8)
(
    input logic [size-1:0] d,
    input logic clk, rst, en,
    output logic [size-1:0] q
);

always_ff @(posedge clk, posedge rst)begin
    if (rst == 1)
        q <= 0;
    else if (en == 0)
        q <= d;
end

endmodule