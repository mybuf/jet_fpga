
vlib work
vmap work work

vlog -reportprogress 300 -work work ./*.v
vlog -reportprogress 300 -work work ./xlib/*.v
vlog -reportprogress 300 -work work ../src/*.v
vlog -reportprogress 300 -work work ../ipcore_dir/*.v

vsim -novopt work.testbench

do wave.do

run -all

