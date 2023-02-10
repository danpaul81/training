
### Running a web-service app & exploring container

#### 1. Run containerized webserver

change into directory ~/training/02_advanced_container

Check (and modify if wanted) content of ~/html/index.html

This is the content of your webservice.

Execute following command (before actually running it you should read the description below)

`docker run --name nginx --rm -p 5000:80 -v /home/[yourloginname]/training/02_advanced_container/html:/usr/share/nginx/html:ro nginx:latest`

What happens?:

`docker run`  runs a container image

`--name` defines a name for the running container, easier for later reference

`-rm` deletes container image when its stopped

`-p 5000:80` exposes network port 80 from inside the container image to your host port 5000, which makes the application accessible from outside

`-v ......:ro` mounts the local html directory read-only to a specified path inside the container image. Used to "inject" data into a container

`nginx:latest` defines to run the latest official nginx container from dockerhub

As this container now displays its log on the console open a second ssh console to your vm

open http://[IP of your VM]:5000 in your browser

The Website should be displayed, console log will show access to the webserver

#### 2. Inspect content of running container

##### 2.1 Inspect Container

open a second ssh console to your vm

`docker inspect nginx`

note the "mergeddir (or run `docker inspect nginx | grep MergedDir`)

`sudo ls [MergedDir]` will show root filesystem inside container


##### 2.1 Execute into container environment

`docker exec -it nginx /bin/bash`

You now have a root shell inside the container

Explore the filesystem of the container. 

You'll see the webserver directory (mounted from external) when running

`ls /usr/share/nginx/html`

Exit container

`exit`







