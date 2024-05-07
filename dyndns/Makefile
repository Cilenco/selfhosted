.SILENT:

install:
	docker build -t fastapi/dyndns .

start:
	docker run -d --name DynDns -p 8765:80 fastapi/dyndns

stop:
	docker stop DynDns
