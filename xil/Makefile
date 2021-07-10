DEVICE := xc6slx9
PACKAGE := 2ftg256

WORKDIR := ./work

IMPACT := impact
XFLOW := xflow

# SOURCES is expected to be set to list of files separated by space
# TOP_ENTITY is expected to be set to top entity's name
# TOP_ENTITY_VHDL is expected to be set to top entity's vhdl file path

TOP_ENTITY_BIT := $(WORKDIR)/$(TOP_ENTITY).bit
TOP_ENTITY_BIT_ESCAPED := $(shell echo $(TOP_ENTITY_BIT) | sed "s=\/=\\\/=g")

IMPACT_BATCH := impact.cmd
IMPACT_BATCH_TEMPLATE := impact.cmd.tmplt

SOURCES_LIST := filelist.txt

.PHONY: all compile flash clean

all: compile flash

$(WORKDIR):
	mkdir $(WORKDIR)

$(SOURCES_LIST):
	echo $(SOURCES) | tr " " "\n" > $(SOURCES_LIST)

compile: clean $(WORKDIR) $(SOURCES_LIST)
	cp $(SRCDIR)/*.ucf $(WORKDIR)
	$(XFLOW) -p $(DEVICE)-$(PACKAGE) -g srclist:$(SOURCES_LIST) -synth xst_vhdl.opt -implement balanced.opt -config bitgen.opt $(TOP_ENTITY_VHDL) -wd work

$(IMPACT_BATCH):
	sed -e "s=<bitfile>=$(TOP_ENTITY_BIT_ESCAPED)=g" $(IMPACT_BATCH_TEMPLATE) > $(IMPACT_BATCH)

flash: $(IMPACT_BATCH)
	$(IMPACT) -batch $(IMPACT_BATCH)

clean:
	$(RM) -rf $(WORKDIR)
	$(RM) -rf $(SOURCES_LIST)
	$(RM) -rf $(IMPACT_BATCH)
	$(RM) -rf _impactbatch.log
