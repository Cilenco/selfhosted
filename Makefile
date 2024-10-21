.SILENT:

ifeq ($(words $(MAKECMDGOALS)), 2)
	TARGET := $(word 1, $(MAKECMDGOALS))
	DIR := $(word 2, $(MAKECMDGOALS))

	@echo $(DIR)
	cd $(DIR) && make $(TARGET)
endif

install:
	cd $(app) && make install --no-print-directory

start:
	cd $(app) && make start --no-print-directory

stop:
	cd $(app) && make stop --no-print-directory

update:
	cd $(app) && make update --no-print-directory
