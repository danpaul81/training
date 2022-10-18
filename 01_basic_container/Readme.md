### Delivering a basic containerized App

#### 1. Check & Build your App

change into `~/training/01_basic_container` directory

review hello.go file

Its a golang script showing "Hello World" and showing -if exists- content of greeting.txt file

compile the script

`go build hello.go`

execute it

`./hello`

It should show "Hello World" and an error message regarding the missing file. Thats ok for now

#### 2. Build a Container

##### 2.1 Create Dockerfile

Create "Dockerfile"

```
FROM scratch
COPY ./hello /
CMD ["./hello"]
```

##### 2.2 Create the Container (version 1)

`docker build . -t hello-[yourloginname]:v1`

Show the container image

`docker image ls`

Run the container image

`docker run hello-[yourloginname]:v1`

(should display the same as the previous binary app run)

Inspect the container image

`docker image inspect hello-[yourloginname]:v1`

note the "UpperDir" entry. You can run `sudo ls [UpperDir]` and will see content of container image

##### 2.3 Add a file to container (version 2)

Create greeting.txt

`echo "Greetings from [yourloginname]" > greeting.txt`

edit Dockerfile, add another COPY command. This will result in adding a new storage layer to container image

```
FROM scratch
COPY ./hello /
COPY ./greeting.txt /
CMD ["./hello"]
```

Build a new version of the container image (note the v2 tag)

`docker build . -t hello-[yourloginname]:v2`

run the new version of container image

`docker run hello-[yourloginname]:v2`

(will now display "hello world" and content of greeting.txt)

`docker image inspect hello-[yourloginname]:v2`

* LowerDir entry points to previous container image(s) as theese are now a layer of the new container image
* UpperDir directory contains newly added "greeting.txt"

Feel free to inspect again the directories in file system

#### 3. Tag and Push Container Image

Show content of local image repository

`docker image ls`

Tag your local image to enable push to container registry

`docker tag hello-[yourloginname]:v2 803113055342.dkr.ecr.eu-west-1.amazonaws.com/training:[yourloginname]`

Again show content of local image repository

`docker image ls`

You'll see new tag will display with same Image ID & Size

Push image to container registry 

`docker push 803113055342.dkr.ecr.eu-west-1.amazonaws.com/training:[yourloginname]`

