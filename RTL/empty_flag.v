module empty_flag #(
    parameter ADDR_WIDTH = 4
)(
    input  wire [ADDR_WIDTH:0] rd_gray_next,
    input  wire [ADDR_WIDTH:0] wr_gray_sync,
    output wire                empty
);

    assign empty =
        (rd_gray_next == wr_gray_sync);

endmodule