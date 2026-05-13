module synchronizer #(
    parameter WIDTH = 5
)(
    input  wire             clk,
    input  wire             rst_n,
    input  wire [WIDTH-1:0] din,
    output reg  [WIDTH-1:0] dout
);

    reg [WIDTH-1:0] sync_ff;

    always @(posedge clk or negedge rst_n)
    begin
        if (!rst_n)
        begin
            sync_ff <= 0;
            dout <= 0;
        end
        else
        begin
            sync_ff <= din;
            dout <= sync_ff;
        end
    end

endmodule