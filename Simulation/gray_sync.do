restart -f

quietly WaveActivateNextPane {} 0

add wave sim:/tb_fifo/DUT/wr_bin
add wave sim:/tb_fifo/DUT/wr_gray
add wave sim:/tb_fifo/DUT/rd_bin
add wave sim:/tb_fifo/DUT/rd_gray
add wave sim:/tb_fifo/DUT/wr_gray_sync
add wave sim:/tb_fifo/DUT/rd_gray_sync

run 380ns
wave zoom full