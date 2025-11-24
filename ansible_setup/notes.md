### Static IP

For dual static IP

```yaml
- name: Configure eth0 with two static IPv4 addresses
  become: true
  community.general.nmcli:
    conn_name: wired_ethernet
    ifname: eth0
    type: ethernet
    state: present
    ip4:
      - 192.168.1.10/24
      - 192.168.1.11/24
    gw4: 192.168.1.1
    autoconnect: yes
```

### Public SSH Keys

See https://docs.ansible.com/projects/ansible/latest/collections/ansible/posix/authorized_key_module.html#examples