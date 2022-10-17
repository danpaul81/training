
Inspect hello.go

-> show "Hello World"

-> if file exisits, displays content of "weekday.txt"

compile it

go build hello.go

execute it

./hello


Create "Dockerfile"

FROM scratch

COPY ./hello /

CMD ["./hello"]


docker build . -t hello-yourname

docker run hello-yourname
-> shows the same as the binary run

docker image inspect hello-yourname
note "UpperDir" entry. You can run "sudo ls [UpperDir]" and will see content of container

echo "Hello [yourfullname], its friday" > weekday.txt


edit Dockerfile, add following 

COPY ./weekday.txt

docker build . -t hello-2-yourname

docker run hello-2-yourname

-> should now display "hello world" and content of weekday.txt


docker image inspect hello-2-yourname

-> lowerdir entry still points to previous container as this is now a layer of the new container

-> upperdir directory contains newly added "workday.txt"


docker image ls

docker tag hello-2-yourname:latest 803113055342.dkr.ecr.eu-west-1.amazonaws.com/danielpaul:[yourlogin]

docker push 803113055342.dkr.ecr.eu-west-1.amazonaws.com/danielpaul:[yourlogin]



