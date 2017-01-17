






$array_username_group = @()

$running_group = gwmi win32_group

foreach ($organization in $running_group) {

    
    $temp_group=@{}
    
    $temp_group.Group = $organization.name 
            
        
    $temp_group.User=@()

    $a = (gwmi win32_groupuser | ? {$_.groupcomponent -match $organization.name} |% {[wmi]$_.partcomponent})

                                    foreach ($b in $a){
                                    
                                        $temp_group.User += $b.name

                                    } 

                             

    $array_username_group += $temp_group

                           }


$array_username_group |  ConvertTo-Json | Out-File array_username_group.json



                         
















