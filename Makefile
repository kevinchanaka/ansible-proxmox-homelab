include .env
export $(shell sed 's/=.*//' .env)
.PHONY: template image env

bootstrap:
	ansible-playbook -i hosts.ini playbooks/setup-node.yaml -u root --extra-vars ansible_password='{{ lookup("env", "PROXMOX_PASSWORD") }}'

image: 
	ansible-playbook -i hosts.ini playbooks/download-image.yaml -u root --extra-vars "image_url=$(image_url) ansible_password='{{ lookup(\"env\", \"PROXMOX_PASSWORD\") }}'"

template:
	ansible-playbook -i hosts.ini playbooks/create-template.yaml --extra-vars "image=$(image) vm_name=$(name) vm_id=$(id)"

vms:
	ansible-playbook -i hosts.ini playbooks/create-vms.yaml