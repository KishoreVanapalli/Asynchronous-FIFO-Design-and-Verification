restart -f

quietly WaveActivateNextPane {} 0

add wave sim:/tb_fifo/DUT/rd_clk
add wave sim:/tb_fifo/DUT/rd_en
add wave sim:/tb_fifo/DUT/rdata
add wave sim:/tb_fifo/DUT/rd_bin
add wave sim:/tb_fifo/DUT/empty

run 380ns
wave zoom full