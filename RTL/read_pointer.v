module read_pointer #(
    parameter ADDR_WIDTH = 4
)(
    input  wire                   rd_clk,
    input  wire                   rst_n,
    input  wire                   rd_en,
    input  wire                   empty,
    output reg [ADDR_WIDTH:0]     rd_bin,
    output wire [ADDR_WIDTH:0]    rd_gray
);

    wire incr;

    assign incr = rd_en && !empty;

    always @(posedge rd_clk or negedge rst_n)
    begin
        if (!rst_n)
            rd_bin <= 0;
        else if (incr)
            rd_bin <= rd_bin + 1'b1;
    end

    assign rd_gray = (rd_bin >> 1) ^ rd_bin;

endmodule