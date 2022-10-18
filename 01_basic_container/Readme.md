### Delivering a basic containerized App
<br>
#### Check & Build your App
<br>
change into `~/training/01_basic_container` directory
review hello.go file
Its a golang script showing "Hello World" and showing -if exists- content of greeting.txt file
compile the script
go build hello.go
execute it
./hello
It should show "Hello World" and an error message regarding the missing file. Thats ok for now

#### Build a Container
<br>
Create "Dockerfile"
<br>
```
FROM scratch
COPY ./hello /
CMD ["./hello"]
```

#### Create the Container (version 1)

`docker build . -t hello-[yourloginname]:v1`

Show the container image
docker image ls

Run & Inspect the Container
`docker run hello-[yourloginname]:v1`

(should display the same as the previous binary run)

`docker image inspect hello-[yourloginname]:v1`
note the "UpperDir" entry. You can run "sudo ls [UpperDir]" and will see content of container
If you just want to see the "UppderDir" entry run docker inspect hello\-dpaul:v1 \| grep UpperDir
<br>
#### Add a file to container (version 2)
<br>
<br>
```
echo "Greetings from [yourloginname]" > greeting.txt
```
<br>
edit Dockerfile, add another COPY command. This will result in adding a new storage layer to container image

FROM scratch
COPY ./hello /
COPY ./greeting.txt /
CMD ["./hello"]

docker build . -t hello-[yourloginname]:v2

docker run hello-[yourloginname]:v2

(should now display "hello world" and content of greeting.txt)

docker image inspect hello-[yourloginname]:v2
<br>
* LowerDir entry points to previous container image(s) as theese are now a layer of the new container image
* UpperDir directory contains newly added "greeting.txt"

Feel free to inspect the directories in file system
<br>
#### Tag and Push Container Image
<br>
docker image ls

docker tag hello-[yourloginname]:v2 803113055342.dkr.ecr.eu-west-1.amazonaws.com/training:[yourloginname]

docker image ls

docker push [803113055342.dkr.ecr.eu-west-1.amazonaws.com/training:\[yourloginname](http://803113055342.dkr.ecr.eu-west-1.amazonaws.com/training:%5Byourloginname)]

<br>
<br>
