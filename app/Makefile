build:
	docker build --rm=true -t bitcoin-core .

run:
	docker run -d --name bitcoin-core -p 8333:8333 bitcoin-core

remove:
	docker container rm -f bitcoin-core

scan:
	docker scan bitcoin-core --file=Dockerfile

exec:
	docker exec -it bitcoin-core bash