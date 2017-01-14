$a = gps | select processname | sort | get-unique -AsString > dan.txt
$b = (Get-Content dan.txt | ? {$_ -notmatch "ProcessName"} | ? {$_ -notmatch "-----*"}).Trim() -ne "" | Set-Content dan.txt 
$c = Get-Content dan.txt 
    




foreach ($i in $c){

echo "--------------------------$i----------------------------------" >> final.txt

(gps $i).Modules | select modulename >> final.txt

echo " " >>final.txt

echo " " >>final.txt

            



} 


echo " " >> final.txt

echo "-----------------------------DDL List-----------------------------------">> final.txt

echo " " >> final.txt 

gps | where {$_.processName} | select modules -ExpandProperty Modules 2>>error.log |select modulename 1>dan3.txt 

gc dan3.txt| sort | Get-Unique -AsString > dan4.txt

(Get-Content .\dan4.txt | ? {$_ -notmatch "ModuleName"} | ? {$_ -notmatch "-------*"}).trim() -ne "" 1>dan5.txt 
 
Get-Content .\dan5.txt | Select-String -Pattern "dll" >> final.txt














