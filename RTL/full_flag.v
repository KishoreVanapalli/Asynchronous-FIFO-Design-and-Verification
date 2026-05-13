module full_flag #(
    parameter ADDR_WIDTH = 4
)(
    input  wire [ADDR_WIDTH:0] wr_gray_next,
    input  wire [ADDR_WIDTH:0] rd_gray_sync,
    output wire                full
);

    assign full =
        (wr_gray_next ==
        {~rd_gray_sync[ADDR_WIDTH:ADDR_WIDTH-1],
          rd_gray_sync[ADDR_WIDTH-2:0]});

endmodule