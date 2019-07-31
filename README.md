# amazon-linux-bootstrap

#### you should be able to copy paste a single line and run this command.
#### I recommend running this inside screen in case you get disconected.

source <(curl -s https://raw.githubusercontent.com/thesheff17/amazon-linux-bootstrap/master/bootstrap.sh)

#### you should also be able to test this inside a docker container
time docker build . -t thesheff17/amazonlinuxtest:latest

#### bootstrap your EC2 instance with this script
aws ec2 run-instances --image-id ami-0b898040803850657 --count 1 --instance-type c5.xlarge \
--key-name my-key-pair --subnet-id subnet-abcd1234 --security-group-ids sg-abcd1234 \
--user-data file://bootstrap.sh
