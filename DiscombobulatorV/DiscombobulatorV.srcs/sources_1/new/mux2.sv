module mux2 #( parameter size = 8)
(
    input logic [size-1:0] in0,
    input logic [size-1:0] in1,
    input logic sel,
    output logic [size-1:0] out
);

assign out = sel ? in1:in0;

endmodule