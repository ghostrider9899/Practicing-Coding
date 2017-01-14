echo "=================Malware Detection=================" > test.txt
echo " " >> test.txt
echo "----Date of Time for the System----" >> test.txt
echo " ">> test.txt
get-date >> test.txt
echo " ">> test.txt
echo "--------------------Hostname and Domain--------------------------">> test.txt
echo " " >> test.txt 
hostname >> test.txt
echo " " >> test.txt
$env:USERDOMAIN >> test.txt
echo " " >> test.txt
echo "-----------------Window Groups------------------------">> test.txt
echo " ">> test.txt
Get-WmiObject win32_group | select name >> test.txt 
echo " " >> test.txt
echo "----------------Windows User Accounts-----------------" >> test.txt
echo " " >> test.txt
Get-Wmiobject win32_useraccount  | select name >> test.txt
echo " " >> test.txt
echo "----------------Current Logged in Users---------------" >> test.txt
echo " " >> test.txt
$a = hostname
Get-WmiObject win32_computersystem -ComputerName $a | Format-Table -Property username >> test.txt
echo " " >> test.txt
echo "--------------Services Running on the Machine---------" >> test.txt
echo " " >> test.txt
Get-Service | select name,status >> test.txt
echo " " >> test.txt
echo "--------------Network information---------------------" >> test.txt
echo " " >> test.txt
ipconfig >> test.txt
echo " " >> test.txt
echo "--------------Listening Sockets-----------------------" >> test.txt
echo " " >> test.txt
$data = netstat -ano
$data[3] >> test.txt
$data | Select-String "LISTENING" >> test.txt
echo " " >> test.txt
echo "--------------System Information----------------------" >> test.txt
echo " " >> test.txt
Get-WmiObject Win32_PnPSignedDriver| select devicename, driverversion >> test.txt
echo " " >> test.txt
echo "------------------Mapped Drives-----------------------" >> test.txt
echo " " >> test.txt
Get-PSDrive | select Name,Provider,root >> test.txt
echo " " >> test.txt
echo "------------------Schedule Tasks----------------------" >> test.txt
Get-ScheduledTask >> test.txt
echo " " >> test.txt
echo "------------------Shared Resource---------------------" >> test.txt
echo " " >> test.txt
Get-WmiObject -Class Win32_Share >> test.txt
echo " " >> test.txt
echo "------------------Configured Devices------------------" >> test.txt
echo " " >>test.txt
gwmi Win32_USBControllerDevice |%{[wmi]($_.Dependent)} | sort Description,Deviceid | ft Description,Deviceid -AutoSize >> test.txt
echo " " >> test.txt
echo "----------------Getting System Process----------------" >> test.txt
echo " " >> test.txt
gps | select processname | sort | Get-Unique -AsString >> test.txt 
echo " " >> test.txt
echo "------------------------------------------------------" >> test.txt

echo " " 
$found = $(Read-Host -Prompt "Please name the file")
Rename-Item test.txt $found 2>$null
echo " "
echo "Check your user profile if done correctly at $env:userprofile"







