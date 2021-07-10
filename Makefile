export ROOT := $(shell pwd)
SIMDIR := $(ROOT)/sim
export SRCDIR := $(ROOT)/src
TBDIR := $(ROOT)/testbench
WORKDIR := $(ROOT)/work

#####################################################
#                                                   #
#                 Top level entity                  #
#                                                   #
#####################################################
export TOP_ENTITY := # fill
export TOP_ENTITY_VHDL := $(SRCDIR)/$(TOP_ENTITY).$(VHDLEX)
TESTBENCH ?= $(TOP_ENTITY)_tb # default

WAVEFORM_VIEWER := gtkwave

COMPILER := ghdl
COMPILER_FLAGS := --workdir=$(WORKDIR)
VHDLEX := vhd

STOP_TIME ?= 1000ns
WAVEFORM_FILE ?= $(SIMDIR)/out.gwh

RUN_FLAGS := --stop-time=$(STOP_TIME) --vcd=$(WAVEFORM_FILE) --stats

TBSOURCES := $(wildcard $(TBDIR)/*.$(VHDLEX))
export SOURCES := $(wildcard $(SRCDIR)/*.$(VHDLEX))
ALL_SOURCES := $(SOURCES) $(TBSOURCES)

EXECUTABLE := $(SIMDIR)/$(TESTBENCH)

.PHONY: all clean xil

compile: $(WORKDIR) $(ALL_SOURCES)
	@$(COMPILER) -i $(COMPILER_FLAGS) $(ALL_SOURCES)
	@$(COMPILER) -m -o $(EXECUTABLE) $(COMPILER_FLAGS) $(TESTBENCH)

all: compile run view

$(TBDIR)/$(TESTBENCH): compile

$(WORKDIR):
	@mkdir $(WORKDIR)

$(SIMDIR):
	@mkdir $(SIMDIR)

run: $(TBDIR)/$(TESTBENCH) $(SIMDIR)
	@$(EXECUTABLE) $(RUN_FLAGS)

view:
	@$(WAVEFORM_VIEWER) $(WAVEFORM_FILE)

xil:
	@$(MAKE) -C xil all

xil-flash:
	@$(MAKE) -C xil flash

clean:
	@$(RM) -rf $(SIMDIR)
	@$(RM) -rf $(WORKDIR)
	@$(MAKE) -C ax309 clean

