set project_name "zynq_axi_dma"
set part_name "xc7z020clg400-1"
set top_module_name "Iteration1"

# Creating the project in a build directory
create_project ${project_name} -part ${part_name}

# Recreating the block design from the .bd file
source [glob ../bd/*.tcl]

# Adding the constraints file
add_files -fileset constrs_1 -norecurse [glob ../constraints/*.xdc]

# Generating the HDL wrapper for the block design
make_wrapper -files [get_files ${top_module_name}.bd] -top
add_files -norecurse ${project_name}.srcs/sources_1/bd/${top_module_name}/hdl/${top_module_name}_wrapper.v

# Setting the top module
update_compile_order -fileset sources_1
set_property top ${top_module_name}_wrapper [get_filesets sources_1]

puts "INFO: Project ${project_name} created successfully from block design."