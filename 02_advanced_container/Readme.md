

Run a container including a webservice

docker run --name webservice -p 5000:5000 803113055342.dkr.ecr.eu-west-1.amazonaws.com/danielpaul:latest

Now open http://[IP of your VM]:5000 in your browser


docker inspect webservice

note the "mergeddir (or run docker inspect webservice |grep MergedDir)

sudo ls [MergedDir] will show root filesystem inside container
sudo ls [MergedDir]/golangweb will show content of application directory

Explore access into container environment

docker exec -it webservice /bin/bash

You now have a root shell inside the container

try to create a file inside /golangweb/

touch /golangweb/helloworld

Exit container
exit

re-run sudo ls [MergedDir]/golangweb

should show newly created file






