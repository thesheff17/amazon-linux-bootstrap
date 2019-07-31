FROM amazonlinux

# docker build . -t dsheffner/amazonlinuxtest:latest

COPY ./bootstrap.sh /root/bootstrap.sh

RUN /root/bootstrap.sh

CMD ["/bin/bash"]
