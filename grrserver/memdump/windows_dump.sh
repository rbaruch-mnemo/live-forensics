# RAM DUMP Windows
scp MRC.exe forense@192.168.100.101:"%temp%"
ssh forense@192.168.100.101 "%temp%\MRC.exe /accepteula /silent /go %temp%\windowsRamDump.raw && scp %temp%\*.raw forense@grrserver:/home/forense/"