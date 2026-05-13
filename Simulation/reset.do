restart -f

quietly WaveActivateNextPane {} 0

add wave sim:/tb_fifo/DUT/wr_clk
add wave sim:/tb_fifo/DUT/rd_clk
add wave sim:/tb_fifo/DUT/rst_n
add wave sim:/tb_fifo/DUT/full
add wave sim:/tb_fifo/DUT/empty
add wave sim:/tb_fifo/DUT/wr_bin
add wave sim:/tb_fifo/DUT/rd_bin

run 30ns
wave zoom full