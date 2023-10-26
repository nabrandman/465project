# name of SystemVerilog module
MODULE=alu

# 


#
wave: waveform.vcd

waveform.vcd: ./obj_dir/V$(MODULE)
	./obj_dir/V$(MODULE)

./obj_dir/V$(MODULE): 
	verilator --cc --trace $(MODULE).sv
	verilator --Wall --trace --cc $(MODULE).sv --exe tb_$(MODULE).cpp
	make -C obj_dir -f V$(MODULE).mk V$(MODULE)

# 
.PHONY: clean
clean:
	rm -rf ./obj_dir
	rm waveform.vcd