#cloud-config
hostname: training
users:
  - default
  - name: ${tpl-user}
    groups: users, docker
    sudo: ALL=(ALL) NOPASSWD:ALL
    lock_passwd: false
#20portworx22 openssl passwd -6
    passwd: $6$xNurMQBIXXwEBzGp$.YopbiJyt1EKrmWqhX7V.7cjbs0YRL6W0FUE/raWeO6LCWqOFcIjDamBCZYubbC5e4SIrbN3KlhIUqjgWwPFg/
write_files:
  - content: |
      [default]
      aws_access_key_id = ${tpl-access-key}
      aws_secret_access_key = ${tpl-secret-access-key}
    path: /home/${tpl-user}/.aws/credentials
    permissions: '0600'
runcmd:
- sed -i -e 's\PasswordAuthentication no\PasswordAuthentication yes\g' /etc/ssh/sshd_config
- service sshd restart
- yum install docker git go -y
- systemctl enable docker
- systemctl start docker
- chown -R ${tpl-user}.${tpl-user} /home/${tpl-user}
- sudo -u ${tpl-user} aws ecr get-login-password --region ${tpl-region} | sudo -u ${tpl-user} docker login --username AWS --password-stdin ${tpl-account-id}.dkr.ecr.${tpl-region}.amazonaws.com
- sudo -u ${tpl-user} git clone https://github.com/danpaul81/training.git /home/${tpl-user}/training
