FROM centos

RUN yum install -y nc
 
RUN \
  echo "#!/bin/sh" > /tmp/listen.sh && \
  echo "while true; do nc -l 8080 < /tmp/index.html; done" >> /tmp/listen.sh && \
  chmod u+x /tmp/listen.sh && \
  echo "<html><body>this is a test</body></html>" > /tmp/index.html
 
CMD ["bash"]

# boot2docker init
# boot2docker start
#     export DOCKER_HOST=tcp://192.168.59.105:2376
#     export DOCKER_CERT_PATH=/Users/tom/.boot2docker/certs/boot2docker-vm
#     export DOCKER_TLS_VERIFY=1
# boot2docker ssh
# while true ; do nc -l 80  < index.html ; done
# vi Dockerfile 
# boot2docker stop
# boot2docker start
#     export DOCKER_CERT_PATH=/Users/tom/.boot2docker/certs/boot2docker-vm
#     export DOCKER_TLS_VERIFY=1
#     export DOCKER_HOST=tcp://192.168.59.105:2376
# docker build -t=oneliner .
# docker run -d -p 8080:8080 oneliner /tmp/listen.sh 
# boot2docker ip
# curl 192.168.59.105:8080
# docker logs
# curl 192.168.59.105:8080
# docker run --name web -d -p 8080:8080 oneliner /tmp/listen.sh 
# curl 192.168.59.105:8080
# docker run -t -i --name api --link web:web oneliner /bin/bash
