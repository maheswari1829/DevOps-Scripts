# 🚀 Ansible Multi-Server Setup

## Infrastructure Setup

- 1 Ansible Server
- 2 Development Servers
- 2 Testing Servers

---

# 🖥️ Server Hostnames

```bash
hostnamectl set-hostname ansible
hostnamectl set-hostname dev-1
hostnamectl set-hostname dev-2
hostnamectl set-hostname test-1
hostnamectl set-hostname test-2
```

---

# 🔐 Configure Root Password

```bash
passwd root
```

---

# 🔧 SSH Configuration

Edit SSH configuration:

```bash
vim /etc/ssh/sshd_config
```

Update:
- PermitRootLogin yes
- PasswordAuthentication yes

Restart SSH service:

```bash
systemctl restart sshd
systemctl status sshd
```

---

# ⚙️ Install Ansible

```bash
amazon-linux-extras install ansible2 -y
yum install python python-pip python-devel -y
```

---

# 📂 Configure Inventory File

```bash
vim /etc/ansible/hosts
```

Example:

```ini
[dev]
172.xxx.xxx.xxx
172.xxx.xxx.xxx

[test]
172.xxx.xxx.xxx
172.xxx.xxx.xxx
```

---

# 🔑 Generate SSH Key

```bash
ssh-keygen
```

Press Enter 4 times.

---

# 🔗 Copy SSH Keys

```bash
ssh-copy-id root@<private-ip>
```

Repeat for all servers.

---

# ✅ Verify Connection

```bash
ssh root@<private-ip>
```
