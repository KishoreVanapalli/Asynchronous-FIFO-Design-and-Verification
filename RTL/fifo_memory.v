module fifo_memory #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4
)(
    input  wire                      wr_clk,
    input  wire                      wr_en,
    input  wire                      rd_clk,
    input  wire                      rd_en,
    input  wire [ADDR_WIDTH-1:0]     wr_addr,
    input  wire [ADDR_WIDTH-1:0]     rd_addr,
    input  wire [DATA_WIDTH-1:0]     wdata,
    output reg  [DATA_WIDTH-1:0]     rdata
);

    localparam DEPTH = (1 << ADDR_WIDTH);

    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    always @(posedge wr_clk)
    begin
        if (wr_en)
            mem[wr_addr] <= wdata;
    end

    always @(posedge rd_clk)
    begin
        if (rd_en)
            rdata <= mem[rd_addr];
    end

endmodule