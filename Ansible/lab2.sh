#Task 1 Step 6
ansible -m ping all 

#Task 2 Step 1
ansible -m setup all

#Task 2 Step 2
ansible -m setup -a 'filter=ansible_distribution' all

#Task 2 Step 5b
ansible-playbook lab2/playbook-01.yaml

#Task 3 Step 3
ansible-playbook lab2/control-flow.yaml

#Task 4 Step 4b
python3

#Task 4 Step 4c
import boto3

#Task 4 Step 4c
aws configure

#Task 4 Step 8
ansible-inventory --graph

#Task 4 Step 10
ansible-playbook ping.yaml

