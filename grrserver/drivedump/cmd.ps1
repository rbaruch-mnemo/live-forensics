

.\dd.exe if=\\.\PhysicalDrive<N> of=<name>.dd; scp <name> grr@grrserver:/home/grr/
#.\dd.exe if=\\.\PhysicalDrive2 of=imagen3.dd bs=1440k; scp imagen3.dd grr@192.168.100.100:/home/grr/
.\dd.exe if=\\.\<letter>: of=<name>; scp <name> grr@grrserver:/home/grr/
# .\dd.exe if=\\.\f: of=imagen5.dd; scp imagen5.dd grr@192.168.100.100:/home/grr/