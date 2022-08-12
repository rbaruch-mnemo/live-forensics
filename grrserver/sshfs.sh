apt install sshfs
mkdir /cases/GRR_Server
sshfs -o allow_other,default_permissions <GRR_ServerUser>@<GRR_ServerIP>:<SharePath(/)> /cases/GRR_Server