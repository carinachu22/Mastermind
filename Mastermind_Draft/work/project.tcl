set projDir "C:/Users/Carina/Documents/CompStruct_Project/1d-project-group_15/Mastermind_Draft/work/vivado"
set projName "Mastermind_Draft"
set topName top
set device xc7a35tftg256-1
if {[file exists "$projDir/$projName"]} { file delete -force "$projDir/$projName" }
create_project $projName "$projDir/$projName" -part $device
set_property design_mode RTL [get_filesets sources_1]
set verilogSources [list "C:/Users/Carina/Documents/CompStruct_Project/1d-project-group_15/Mastermind_Draft/work/verilog/au_top_0.v" "C:/Users/Carina/Documents/CompStruct_Project/1d-project-group_15/Mastermind_Draft/work/verilog/reset_conditioner_1.v" "C:/Users/Carina/Documents/CompStruct_Project/1d-project-group_15/Mastermind_Draft/work/verilog/button_conditioner_2.v" "C:/Users/Carina/Documents/CompStruct_Project/1d-project-group_15/Mastermind_Draft/work/verilog/edge_detector_3.v" "C:/Users/Carina/Documents/CompStruct_Project/1d-project-group_15/Mastermind_Draft/work/verilog/phaseTwo_fsm_4.v" "C:/Users/Carina/Documents/CompStruct_Project/1d-project-group_15/Mastermind_Draft/work/verilog/multi_seven_seg_5.v" "C:/Users/Carina/Documents/CompStruct_Project/1d-project-group_15/Mastermind_Draft/work/verilog/pipeline_6.v" "C:/Users/Carina/Documents/CompStruct_Project/1d-project-group_15/Mastermind_Draft/work/verilog/alu_7.v" "C:/Users/Carina/Documents/CompStruct_Project/1d-project-group_15/Mastermind_Draft/work/verilog/regfile_8.v" "C:/Users/Carina/Documents/CompStruct_Project/1d-project-group_15/Mastermind_Draft/work/verilog/sel_mux_9.v" "C:/Users/Carina/Documents/CompStruct_Project/1d-project-group_15/Mastermind_Draft/work/verilog/counter_10.v" "C:/Users/Carina/Documents/CompStruct_Project/1d-project-group_15/Mastermind_Draft/work/verilog/counter_11.v" "C:/Users/Carina/Documents/CompStruct_Project/1d-project-group_15/Mastermind_Draft/work/verilog/seven_seg_12.v" "C:/Users/Carina/Documents/CompStruct_Project/1d-project-group_15/Mastermind_Draft/work/verilog/decoder_13.v" "C:/Users/Carina/Documents/CompStruct_Project/1d-project-group_15/Mastermind_Draft/work/verilog/comparator_14.v" "C:/Users/Carina/Documents/CompStruct_Project/1d-project-group_15/Mastermind_Draft/work/verilog/adder_15.v" "C:/Users/Carina/Documents/CompStruct_Project/1d-project-group_15/Mastermind_Draft/work/verilog/shifter_16.v" "C:/Users/Carina/Documents/CompStruct_Project/1d-project-group_15/Mastermind_Draft/work/verilog/boolean_17.v" "C:/Users/Carina/Documents/CompStruct_Project/1d-project-group_15/Mastermind_Draft/work/verilog/multiplier_18.v" ]
import_files -fileset [get_filesets sources_1] -force -norecurse $verilogSources
set xdcSources [list "C:/Users/Carina/Documents/CompStruct_Project/1d-project-group_15/Mastermind_Draft/work/constraint/alchitry.xdc" "C:/Program\ Files/Alchitry/Alchitry\ Labs/library/components/au.xdc" "C:/Users/Carina/Documents/CompStruct_Project/1d-project-group_15/Mastermind_Draft/work/constraint/io.xdc" ]
read_xdc $xdcSources
set_property STEPS.WRITE_BITSTREAM.ARGS.BIN_FILE true [get_runs impl_1]
update_compile_order -fileset sources_1
launch_runs -runs synth_1 -jobs 16
wait_on_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs 16
wait_on_run impl_1
