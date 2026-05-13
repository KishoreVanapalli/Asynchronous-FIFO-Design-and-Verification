module gray_counter #(
    parameter PTR_WIDTH = 5
)(
    input  wire [PTR_WIDTH-1:0] bin,
    output wire [PTR_WIDTH-1:0] gray
);

    assign gray = (bin >> 1) ^ bin;

endmodule