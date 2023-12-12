#!/usr/bin/env sh

# Change into directory
cd "$(dirname "$0")" || exit

ANSIBLE_HOME=..

ansible-galaxy install -r "$ANSIBLE_HOME/requirements.yml"
ansible-playbook -v -i "$ANSIBLE_HOME/hosts" "$ANSIBLE_HOME/000_main.yaml" --ask-become-pass --ask-vault-pass
