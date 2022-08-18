# RAM DUMP Linux
scp avml root@192.168.100.105:"/tmp"
ssh root@192.168.100.105 "chmod +x /tmp/avml && /tmp/avml /tmp/memdumpLinux.lime && scp /tmp/memdumpLinux.lime grr@grrserver:/home/grr/"