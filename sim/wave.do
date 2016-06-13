onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group top -radix hexadecimal /testbench/clk_i
add wave -noupdate -group top -radix hexadecimal /testbench/reset_i
add wave -noupdate -group top -radix hexadecimal /testbench/spi_cs
add wave -noupdate -group top -radix hexadecimal /testbench/spi_sclk
add wave -noupdate -group top -radix hexadecimal /testbench/spi_miso
add wave -noupdate -group top -radix hexadecimal /testbench/spi_mosi
add wave -noupdate -group top -radix hexadecimal /testbench/set_wr_en
add wave -noupdate -group top -radix hexadecimal /testbench/set_wr_addr
add wave -noupdate -group top -radix hexadecimal /testbench/set_wr_data
add wave -noupdate -group top -radix hexadecimal /testbench/set_rd_en
add wave -noupdate -group top -radix hexadecimal /testbench/set_rd_addr
add wave -noupdate -group top -radix hexadecimal /testbench/set_rd_data
add wave -noupdate -group top -radix hexadecimal /testbench/dataBuf
add wave -noupdate -group top -radix hexadecimal /testbench/t_out
add wave -noupdate -group top2 -radix hexadecimal /testbench/u1_net/clk_i
add wave -noupdate -group top2 -radix hexadecimal /testbench/u1_net/reset_i
add wave -noupdate -group top2 -radix hexadecimal /testbench/u1_net/spi_cs
add wave -noupdate -group top2 -radix hexadecimal /testbench/u1_net/spi_sclk
add wave -noupdate -group top2 -radix hexadecimal /testbench/u1_net/spi_miso
add wave -noupdate -group top2 -radix hexadecimal /testbench/u1_net/spi_mosi
add wave -noupdate -group top2 -radix hexadecimal /testbench/u1_net/fpga_int_out
add wave -noupdate -group top2 -radix hexadecimal /testbench/u1_net/t_out
add wave -noupdate -group top2 -radix hexadecimal /testbench/u1_net/setWrEn
add wave -noupdate -group top2 -radix hexadecimal /testbench/u1_net/setWrAddr
add wave -noupdate -group top2 -radix hexadecimal /testbench/u1_net/setWrData
add wave -noupdate -group top2 -radix hexadecimal /testbench/u1_net/setRdEn
add wave -noupdate -group top2 -radix hexadecimal /testbench/u1_net/setRdAddr
add wave -noupdate -group top2 -radix hexadecimal /testbench/u1_net/setRdData
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/clk_i
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/reset_i
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/spi_cs
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/spi_sclk
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/spi_miso
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/spi_mosi
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/fpga_int_out
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/set_wr_en
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/set_wr_addr
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/set_wr_data
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/set_rd_en
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/set_rd_addr
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/set_rd_data
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/t_out
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/sclkShift
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/sclkPos1
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/sclkPos2
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/sclkPos3
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/sclkPos4
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/dataShift
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/bitCount
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/wordFlag
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/wordCount
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/headFlag
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/baseAddr
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/rwFlag
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/sclkNeg1
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/sclkNeg2
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/sclkNeg3
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/sclkNeg4
add wave -noupdate -expand -group net -radix hexadecimal /testbench/u1_net/u1_net/dataRdShift
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1 ns}
