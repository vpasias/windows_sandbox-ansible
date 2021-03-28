# Windows lab sandbox with Ansible
Just a template lab using vagrant and ansible.

Requirements:
  - Vagrant
  - VirtualBox
  - 4 Core CPU (min)
  - 16GB Memory (min)
  - 300GB Storage (min)

 Creates 9 Virtual Machines:
  - Ansible Controller (Ubuntu 20.04 with Ansible, Playbooks, and Hosts configured)
  - IT Security Box (Rolling Kali instance)
  - Windows Box (Windows 10 instance, joined to domain)
  - DC Server (Windows 2019 instance, DC "vipnet.local")
  - Elastic Server (Ubuntu 20.04 with elastic stack, configured for winlogbeat)
  - 3 Cluster Servers
  - 1 Storage Server

Addresses:
  - ac:                       172.16.10.6
  - cl1.vipnet.local:         172.16.10.31
  - dc1.vipnet.local:         172.16.10.2
  - es:                       172.16.10.8
  - itsec:                    172.16.10.29
  - cs1:                      172.16.10.10
  - cs2:                      172.16.10.11
  - cs3:                      172.16.10.12
  - ss1:                      172.16.10.13

