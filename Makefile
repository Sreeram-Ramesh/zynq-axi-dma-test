# Makefile for the AXI DMA Project
# Defines simple commands to build and clean the project.

VIVADO       := vivado
PROJECT_NAME := zynq_axi_dma
BUILD_DIR    := ./build
SCRIPT_DIR   := ./scripts
PROJECT_TCL  := ${SCRIPT_DIR}/create_project.tcl

# Default target when you just type 'make'
all: project

# Target to create the Vivado project
project:
	@echo "INFO: Creating Vivado project in ${BUILD_DIR}..."
	@mkdir -p ${BUILD_DIR}
	@cd ${BUILD_DIR} && ${VIVADO} -mode batch -source ../${PROJECT_TCL}
	@echo "INFO: Project generation complete."

# Target to clean all generated files
clean:
	@echo "INFO: Removing build directory..."
	@rm -rf ${BUILD_DIR} ./.Xil/ ./vivado.jou ./vivado.log ./vivado_pid66279.str

# Target to open the generated project in the GUI
gui:
	@${VIVADO} ${BUILD_DIR}/${PROJECT_NAME}.xpr

# Target to copy the final bitstream and hwh files to a 'deploy' folder.
deploy:
	@echo "INFO: Copying bitstream and hwh file to deploy/ directory..."
	@mkdir -p deploy
	@cp ${BUILD_DIR}/${PROJECT_NAME}.runs/impl_1/${TOP_MODULE_NAME}_wrapper.bit ./deploy/design.bit
	@cp ${BUILD_DIR}/${PROJECT_NAME}.runs/impl_1/${TOP_MODULE_NAME}_wrapper.hwh ./deploy/design.hwh
	@echo "INFO: Files ready in 'deploy/' directory. Copy them to your PYNQ board."

# Prevents 'make' from getting confused if files named 'clean' or 'project' exist
.PHONY: all project clean gui deploy