#Author: Lewis McKee 
#Lookup intel CPU on the intel ARK
#Useful for knowing which Well or Lake you have

function CPUlookUp(){
    param(
        [string]$Use
    )

$CPU = Get-CimInstance CIM_Processor
$CPUQ = $CPU.Name

#break up the string into array objects
    $CPUI = $CPUQ.Split(' ')

    $a = $CPUI[2]
Write-Host $CPUI[2]

#Detect the CPU Manufacturer, Specify which case is required for the $use switch
    Switch ($CPU.Manufacturer){

        GenuineIntel{
            Write-Host "you have a genuine intel"

            $Use = "IntelArk"
        }
        GenuineAMD{
            Write-Host "you have a genuine AMD"

            $Use = "AMD Ark"
        }
    }
#Build out the Query
    Switch ($Use) {

    "IntelArk" { 
    Write-Host "Checking with Intel..."
    $Query = "https://ark.intel.com/search?q=$a"
    }
    "AMD Ark"{
        Write-Host "Checking with AMD..."
        $Query = "https://products.amd.com/en-gb/search#k=$a"
    }

    Default {
        $Query = "No Search Engine Specified"
    }
}

If ($Query -NE "No Search Engine Specified") {
## -- Detect the Default Web Browser
Start $Query
}
Else {
Write-Host
Write-Host $Query -ForeGroundColor "Yellow"
Write-Host "Execution of the Script Has been Ternimated." -ForeGroundColor "Yellow"
Write-Host
}

}

CPUlookUp
