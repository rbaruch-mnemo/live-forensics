# RAM DUMP Windows
echo "hola123.," | sshpass scp MRC.exe grragent@192.168.100.101:"%temp%"
echo "hola123.," | sshpass ssh grragent@192.168.100.101 "%temp%\MRC.exe /accepteula /silent /go %temp%\windowsRamDump.raw && scp %temp%\*.raw grr@grrserver:/home/grr/"