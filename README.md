
## Steps to clone repo and run playbook
Run the following commands to clone the repo and change the working directory
1. git clone https://github.com/iykmode/erigon.git
2. cd erigon 

## Requirements
There is a 'host-dev' file and 'ansible.cfg' file on the root path of this directory structure.
Replace the placeholder for ansible_host in host-dev with your <server_public_IP>.
Also in the ansible.cfg file replace the place holders for remote_user and private_key_file with the <remote_login_user> and your <location_to_private_key> respectively for ansible access to the target server via SSH.

## Steps to run playbook

In this repo the playbooks are congregated in the 'all-playbooks.yml' playbook and are all in the playbooks folder located at the root directory. Roles are also used here to provision the environment.

Run the all-playbook.yml playbook with the following command:

1. ansible-playbook playbook/all-playbooks.yml 

## Note
- The all-playbooks.yml playbook also contains a playbook deploy a nomad job to the target server.

- The target server has a single already partitioned drive that was mounted on the root path, so a directory called /erigon was created and used to prepare the volume mount to docker called /ledgerdata to persist data. 
 
## Verify deployment
Verify that the nomad job ran successfully by with the following url:

http://<server_public_IP>:4646/ui/jobs

