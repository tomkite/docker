# Build and use images

## build and run u1604py3:01 image from ubuntu:16.04
```
docker build -t u1604py3:01 -f Dockerfile-u1604-python3 .
docker run -it --hostname u1604py3 --name u1604py3 --rm u1604py3:01
docker rm -f u1604py3
```

## build and run u1604py3sshd:01 image from u1604py3:01
```
docker build -t u1604py3sshd:01 -f Dockerfile-u1604-python3-sshd .
docker run -d -p 8022:22 --name test_sshd u1604py3sshd:01
docker port test_sshd 22
ssh -i .ssh/id_rsa root@localhost -p 8022
ssh localdocker #requires .ssh/config and /etc/hosts changes
docker stop test_sshd && docker rm -f test_sshd
```

## may use vagrant to launch a docker container
Dockerfile
```
FROM centos

RUN yum install -y nc
 
RUN \
  echo "#!/bin/sh" > /tmp/listen.sh && \
  echo "while true; do nc -l 8080 < /tmp/index.html; done" >> /tmp/listen.sh && \
  chmod u+x /tmp/listen.sh && \
  echo "<html><body>this is a test</body></html>" > /tmp/index.html
 
CMD ["bash"]
```
To test docker
```
docker build -t=oneliner .
docker run --name web -d -p 8080:8080 oneliner /tmp/listen.sh 
curl locahost:8080
docker run -t -i --name api --link web:web oneliner /bin/bash
```
Vagrantfile
```
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker'
 
Vagrant.configure("2") do |config|
  config.vm.define "oneliner" do |a|
    a.vm.provider "docker" do |d|
      d.build_dir = "."
      d.build_args = ["-t=oneliner"]
      d.ports = ["8022:22"]
      d.name = "oneliner"
      d.remains_running = true
      d.cmd = ["/tmp/listen.sh"]
      # d.volumes = ["/src/vertx/:/usr/local/src"]
    end
  end
end
``

