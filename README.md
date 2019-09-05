# amazon-linux-bootstrap
#### bootstrap your EC2 instance with this script

# clone the repo 
```
git clone https://github.com/thesheff17/amazon-linux-bootstrap
cd amazon-linux-bootstrap
```

Replace key-name, subnet-id, and security-group-ids in the next command.  

```
aws ec2 run-instances --image-id ami-0080e4c5bc078760e --count 1 --instance-type t3.large \
--key-name abc --subnet-id subnet-abc --security-group-ids sg-abc \
--tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=yourLabel}]' \
--block-device-mapping file://mapping.json \
--associate-public-ip-address --user-data file://bootstrap.sh
```
