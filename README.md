
## Steps to clone repo and run playbook
Run the following commands to clone the repo and to change into the working directory respectively:

1. git clone https://github.com/iykmode/erigon.git
2. cd erigon 

## Requirements

Replace the placeholder, <server_public_IP>, in the host-dev with the public IP of your server.

Replace the placeholders, <remote_login_user> and <remote_login_user>, in ansible.cfg with your "remote user" and "path to you private key file" respectively.

## Steps to run playbook

All playbooks are in the playbook directory, and they are all congregated in the 'all-playbooks.yml' playbook. 

Roles were used in the setup.yml playbook to provision the environment.

Run the all-playbook.yml playbook with the following command:

1. ansible-playbook playbook/all-playbooks.yml 

## Note
- A deploy.yml playbook is used to deploy the nomad job to the target server; it is also congregated into all-playbooks.yml.

- The target server had a single already partitioned drive that was mounted on the root path. A directory called /erigon was created and is used to prepare the volume (labelled, /ledgerdata) which is mounted to the erigon docker container. 
 
## Verify deployment
Verify that the nomad job ran successfully by with the following url:

http://<server_public_IP>:4646/ui/jobs

