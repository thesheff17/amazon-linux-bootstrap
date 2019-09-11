FROM thesheff17/amazon-linux-base

# time docker build . -t dsheffner/amazonlinuxtest:latest

COPY ./bootstrap_nodocker.sh /root/bootstrap_nodocker.sh

RUN /root/bootstrap_nodocker.sh

CMD ["/bin/bash"]
