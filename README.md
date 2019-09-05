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

### how does this scripts work:

```
bootstrap.sh - bash script that runs updates, installs python3, and pip installs request module
start.py     - a super simple script wrapped around a json object running on cloudflare workers
               here: https://summer-scene-61e0.thesheff17.workers.dev/
mapping.json - sets the / volume of the container to 100GB
starttmux.sh - a decent split of tmux panes
```
