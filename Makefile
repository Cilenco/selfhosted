.SILENT:

include env
export

install:
	cd $(app) && make install --no-print-directory

start:
	cd $(app) && make start --no-print-directory

stop:
	cd $(app) && make stop --no-print-directory

update:
	cd $(app) && make update --no-print-directory
