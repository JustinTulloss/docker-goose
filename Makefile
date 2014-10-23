build:
	docker build -t jmtulloss/goose .

push: build
	docker push jmtulloss/goose
