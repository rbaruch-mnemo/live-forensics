# RAM DUMP Linux
scp avml grragent@192.168.100.20:"/tmp"
ssh grragent@192.168.100.20 "chmod +x /tmp/avml && /tmp/avml /tmp/memdumpLinux.lime && scp /tmp/memdumpLinux.lime grr@grrserver:/home/grr/"

#ssh grragent@192.168.100.20 "su -c 'chmod +x /tmp/avml && /tmp/avml /tmp/memdumpLinux.lime'  && scp /tmp/memdumpLinux.lime grr@grrserver:/home/grr/"