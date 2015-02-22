FROM centos

RUN yum install -y nc
 
RUN \
  echo "#!/bin/sh" > /tmp/listen.sh && \
  echo "while true; do nc -l 8080 < /tmp/index.html; done" >> /tmp/listen.sh && \
  chmod u+x /tmp/listen.sh && \
  echo "<html><body>this is a test</body></html>" > /tmp/index.html
 
CMD ["bash"]
