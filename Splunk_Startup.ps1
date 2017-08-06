#Checking to see if your running as administrator


If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) 

{
    Write-Warning "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"
   
    sleep 3

    break
}


else {

# Initialize Objects (Creating Empty Arrays)
$worked_dns = @()
$failed_dns = @()


# Getting the DNS file from User Input

$myFile = $(Read-Host -prompt "Please enter the absolute path to your file name including file name")

$openFile = $(Get-Content $myFile -ErrorAction SilentlyContinue)


If (![System.IO.File]::Exists($myFile)) {  



    Write-Warning "$myFile is not a valid file, Please enter a valid file name and path!!!!!!"
    
    sleep 3
    
    break 
    
    } 


else { 

                foreach( $proc in $openFile ) {

                #Temp store of data in array

                $temp_service_storage = @{}

                #Getting the Service Name, Checking Existing of splunkd


                $checking_Service = $(get-service -ComputerName $proc -name splunkd -ErrorAction SilentlyContinue)

                
                if ( $checking_Service.status -eq "running" -or $checking_Service.status -eq "stopped" ) { 

                    Stop-Service -InputObject $checking_Service.ServiceName -Force  

                    Start-Service -InputObject $checking_Service.ServiceName 



                     if ( $? -match "true" ) {

                         #Add the Computer to successfully restarting splunkd

                         $temp_service_storage = $proc

                         $worked_dns += $proc
                                                                                       
                                             }

                     else {
                                                                
                         $temp_service_storage = $proc

                         $failed_dns += $proc

                          } 
                          
                            }

                else {
                
                    $temp_service_storage = $proc

                    $failed_dns += $proc }

                                                           
                                                           
                $failed_dns | Sort-Object | Out-File Failed_Restart.txt
                $worked_dns | Sort-Object | Out-File Successful_Restart.txt

                echo "Please Check your current directory for the Failed_Restart.txt and Successful_Restart.txt. These files indicate which servers successful started up the splunk services and which ones failed"
                 
                                                           
                                                           
                                                           
                                                           
                                                           
                                                               } 
    
                  }

                  
}






