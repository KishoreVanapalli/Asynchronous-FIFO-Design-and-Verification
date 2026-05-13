module write_pointer #(
    parameter ADDR_WIDTH = 4
)(
    input  wire                   wr_clk,
    input  wire                   rst_n,
    input  wire                   wr_en,
    input  wire                   full,
    output reg [ADDR_WIDTH:0]     wr_bin,
    output wire [ADDR_WIDTH:0]    wr_gray
);

    wire incr;

    assign incr = wr_en && !full;

    always @(posedge wr_clk or negedge rst_n)
    begin
        if (!rst_n)
            wr_bin <= 0;
        else if (incr)
            wr_bin <= wr_bin + 1'b1;
    end

    assign wr_gray = (wr_bin >> 1) ^ wr_bin;

endmodule