# UFW
* `ufw {rule-here} comment '{comment-text-here}'`
* `ufw allow proto tcp from any to any port 22,80,443 comment 'some comment'`
* * `ufw allow from 10.105.28.0/24 to 10.105.29.1 port 22 proto tcp comment 'some comment'`
* `ufw allow from 10.105.28.0/24 to any port 22 comment 'some comment'`
* `ufw allow from any to any port 22 proto tcp comment 'some comment'`
* `ufw status numbered`
* `ufw delete <N>`
