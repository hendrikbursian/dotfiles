#!/usr/bin/env bash
ansible-galaxy install -r requirements.yml
ansible-playbook -i $HOME/.dotfiles/ansible/hosts $HOME/.dotfiles/ansible/main.yml --ask-become-pass --ask-vault-pass
