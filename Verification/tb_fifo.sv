`timescale 1ns/1ps

module tb_fifo;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 4;

reg wr_clk;
reg rd_clk;
reg rst_n;

reg wr_en;
reg rd_en;

reg [DATA_WIDTH-1:0] wdata;

wire [DATA_WIDTH-1:0] rdata;
wire full;
wire empty;

fifo_top #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
) DUT (
    .wr_clk(wr_clk),
    .rd_clk(rd_clk),
    .rst_n(rst_n),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .wdata(wdata),
    .rdata(rdata),
    .full(full),
    .empty(empty)
);

initial begin
    wr_clk = 0;
    forever #5 wr_clk = ~wr_clk;
end

initial begin
    rd_clk = 0;
    forever #7 rd_clk = ~rd_clk;
end

initial begin
    rst_n = 0;
    wr_en = 0;
    rd_en = 0;
    wdata = 0;

    #30;
    rst_n = 1;
end

integer i;

initial begin

    @(posedge rst_n);

    $display("START WRITE TEST");

    for(i=0;i<10;i=i+1)
    begin
        @(posedge wr_clk);

        if(!full)
        begin
            wr_en = 1;
            wdata = i;
        end
    end

    @(posedge wr_clk);
    wr_en = 0;

    #100;

    $display("START READ TEST");

    for(i=0;i<10;i=i+1)
    begin
        @(posedge rd_clk);

        if(!empty)
            rd_en = 1;
    end

    @(posedge rd_clk);
    rd_en = 0;

    #100;

    $display("SIMULTANEOUS READ WRITE TEST");

    repeat(20)
    begin
        @(posedge wr_clk);

        wr_en = $random % 2;
        rd_en = $random % 2;
        wdata = $random;
    end

    wr_en = 0;
    rd_en = 0;

    #500;

    $display("SIMULATION FINISHED");
    $finish;
end

initial
begin
    $monitor(
        "T=%0t WR=%0d RD=%0d WDATA=%0h RDATA=%0h FULL=%0d EMPTY=%0d",
        $time,
        wr_en,
        rd_en,
        wdata,
        rdata,
        full,
        empty
    );
end

endmodule