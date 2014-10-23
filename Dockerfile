#base the docker container off of a trusted golang image
FROM golang:latest

#install goose
RUN go get 'bitbucket.org/liamstask/goose/cmd/goose'

#mount the app
RUN mkdir -p /opt/db
ONBUILD ADD ./dbconf.yml /opt/db/dbconf.yml
ONBUILD ADD ./migrations /opt/db/migrations

#set the working directory to /opt/go/app
WORKDIR /opt/

#define go as the entrypoint
ENTRYPOINT ["/go/bin/goose", "--env=default"]
CMD ["up"]
