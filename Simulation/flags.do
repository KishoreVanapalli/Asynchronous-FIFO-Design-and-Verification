restart -f

quietly WaveActivateNextPane {} 0

add wave sim:/tb_fifo/DUT/wr_en
add wave sim:/tb_fifo/DUT/rd_en
add wave sim:/tb_fifo/DUT/full
add wave sim:/tb_fifo/DUT/empty
add wave sim:/tb_fifo/DUT/wr_bin
add wave sim:/tb_fifo/DUT/rd_bin
add wave sim:/tb_fifo/DUT/wr_gray_sync
add wave sim:/tb_fifo/DUT/rd_gray_sync

run 380ns
wave zoom full