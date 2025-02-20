#!/bin/bash

cat <<EOF > inventory.ini
[servers]
$1 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/my_ssh_key.pem
EOF

cat <<EOF > docker-compose.yml
version: '3.1'

services:
  backend:
    image: $2
    restart: always
    ports:
      - 3333:3333
EOF

# Create Ansible playbook
cat <<EOF > playbook.yml
- name: Deploy Docker Container
  hosts: servers
  become: yes
  tasks:
    - name: Copy docker-compose.yml to the server
      ansible.builtin.copy:
        src: docker-compose.yml
        dest: docker-compose.yml
        owner: ubuntu
        group: ubuntu
        mode: '0644'

    - name: Run Docker Container
      ansible.builtin.shell: |
        docker compose -f /home/ubuntu/docker-compose.yml up -d
      args:
        chdir: /home/ubuntu
EOF

