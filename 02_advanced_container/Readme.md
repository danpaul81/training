
### Running a web-service app & exploring container

#### 1. Run app and expose webservice

run a container including a webservice

`docker run --name webservice -p 5000:5000 803113055342.dkr.ecr.eu-west-1.amazonaws.com/danielpaul:latest`

--name defines a name for the running container
-p exposes container app running on port 5000 to node VM port 5000

As this container now displays its log on the console open a second console to your vm

open http://[IP of your VM]:5000 in your browser

#### 2. Inspect content of running container

##### 2.1 Inspect Container

`docker inspect webservice`

note the "mergeddir (or run `docker inspect webservice | grep MergedDir`)

`sudo ls [MergedDir]` will show root filesystem inside container

`sudo ls [MergedDir]/golangweb` will show content of application directory

##### 2.1 Execute into container environment

`docker exec -it webservice /bin/bash`

You now have a root shell inside the container

try to create a file inside directory /golangweb/

`touch /golangweb/helloworld`

Exit container

`exit`

re-run `sudo ls [MergedDir]/golangweb`

should show newly created file in the host file system






