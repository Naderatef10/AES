vlog -L mtiAvm -L mtiRnm -L mtiOvm -L mtiUvm -L mtiUPF -L infact AES_tb.sv
vsim -assertdebug -coverage -c -voptargs=+acc work.AES_tb -do "add wave -position insertpoint sim:/AES_tb/*; 
run -all; coverage report -codeAll -cvg -verbose"






#vlog AES_tb.sv 
#vopt +acc=a AES_tb -o dbgver
#vsim -assertdebug dbgver
#atv log -enable /AES_tb

#run -all

#view assertion