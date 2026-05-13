vlog ../RTL/*.v

vsim -voptargs=+acc work.tb_fifo
add wave sim:/tb_fifo/DUT/*
run -all