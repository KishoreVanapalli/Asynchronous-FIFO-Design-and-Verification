restart -f

quietly WaveActivateNextPane {} 0

add wave sim:/tb_fifo/DUT/wr_clk
add wave sim:/tb_fifo/DUT/wr_en
add wave sim:/tb_fifo/DUT/wdata
add wave sim:/tb_fifo/DUT/wr_bin
add wave sim:/tb_fifo/DUT/wr_gray
add wave sim:/tb_fifo/DUT/full

run 160ns
wave zoom full