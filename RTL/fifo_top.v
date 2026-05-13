module fifo_top #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4
)(
    input  wire                     wr_clk,
    input  wire                     rd_clk,
    input  wire                     rst_n,
    input  wire                     wr_en,
    input  wire                     rd_en,
    input  wire [DATA_WIDTH-1:0]    wdata,
    output wire [DATA_WIDTH-1:0]    rdata,
    output wire                     full,
    output wire                     empty
);

    localparam PTR_WIDTH = ADDR_WIDTH + 1;

    wire [PTR_WIDTH-1:0] wr_bin;
    wire [PTR_WIDTH-1:0] rd_bin;

    wire [PTR_WIDTH-1:0] wr_gray;
    wire [PTR_WIDTH-1:0] rd_gray;

    wire [PTR_WIDTH-1:0] wr_gray_sync;
    wire [PTR_WIDTH-1:0] rd_gray_sync;

    wire [PTR_WIDTH-1:0] wr_gray_next;
    wire [PTR_WIDTH-1:0] rd_gray_next;

    assign wr_gray_next =
        ((wr_bin + (wr_en && !full)) >> 1) ^
         (wr_bin + (wr_en && !full));

    assign rd_gray_next =
        ((rd_bin + (rd_en && !empty)) >> 1) ^
         (rd_bin + (rd_en && !empty));

    write_pointer #(
        .ADDR_WIDTH(ADDR_WIDTH)
    ) u_wr_ptr (
        .wr_clk(wr_clk),
        .rst_n(rst_n),
        .wr_en(wr_en),
        .full(full),
        .wr_bin(wr_bin),
        .wr_gray(wr_gray)
    );

    read_pointer #(
        .ADDR_WIDTH(ADDR_WIDTH)
    ) u_rd_ptr (
        .rd_clk(rd_clk),
        .rst_n(rst_n),
        .rd_en(rd_en),
        .empty(empty),
        .rd_bin(rd_bin),
        .rd_gray(rd_gray)
    );

    synchronizer #(
        .WIDTH(PTR_WIDTH)
    ) sync_r2w (
        .clk(wr_clk),
        .rst_n(rst_n),
        .din(rd_gray),
        .dout(rd_gray_sync)
    );

    synchronizer #(
        .WIDTH(PTR_WIDTH)
    ) sync_w2r (
        .clk(rd_clk),
        .rst_n(rst_n),
        .din(wr_gray),
        .dout(wr_gray_sync)
    );

    full_flag #(
        .ADDR_WIDTH(ADDR_WIDTH)
    ) u_full (
        .wr_gray_next(wr_gray_next),
        .rd_gray_sync(rd_gray_sync),
        .full(full)
    );

    empty_flag #(
        .ADDR_WIDTH(ADDR_WIDTH)
    ) u_empty (
        .rd_gray_next(rd_gray_next),
        .wr_gray_sync(wr_gray_sync),
        .empty(empty)
    );

    fifo_memory #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) u_mem (
        .wr_clk(wr_clk),
        .wr_en(wr_en && !full),
        .rd_clk(rd_clk),
        .rd_en(rd_en && !empty),
        .wr_addr(wr_bin[ADDR_WIDTH-1:0]),
        .rd_addr(rd_bin[ADDR_WIDTH-1:0]),
        .wdata(wdata),
        .rdata(rdata)
    );

endmodule