function Get-UnicodeScript {

<#
.SYNOPSIS
    Get the Script property of a Unicode glyph.
.DESCRIPTION
    Get-UnicodeScript is a PowerShell function that queries the Unicde DataBase (UDB) for information
    on the Script property of a given glyph. It requires an Internet connection to download the UDB.
.PARAMETER Glyph
    A Unicode glyph.
.EXAMPLE
     Get-UnicodeScript -Glyph 'Ω'
.EXAMPLE
     '£' | Get-UnicodeScript
.NOTES
    Author:  Carlo MANCINI
    Website: http://www.happysysadm.com
    Twitter: @sysadm2010
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,ValueFromPipeline=$True)][char]$Glyph
    )

if(!$scriptsinfo){ 

    $sourcescripts = "http://www.unicode.org/Public/UNIDATA/Scripts.txt"

    $scriptsweb = Invoke-WebRequest $sourcescripts

    $global:scriptsinfo = ($scriptsweb.content.split("`n").trim() -ne "") | sls "^#" -n | convertfrom-csv -Delimiter ';' -header "range","scriptname"

    }

$decimal = [int][char]$glyph

foreach($line in $scriptsinfo){

    #Splitting each range to the double points ..
    $hexrange = $line.range.split('..')

    #Getting the start value of the range
    $hexstartvalue = $hexrange[0].trim()

    #Getting the end value of the range (if it exists, hence the try/catch)
    try{
        
        $hexendvalue = $hexrange[2].trim()
        
        }
        
    catch{
    
        $hexendvalue = $null
        
        }
    
    #Converting the start value from he to decimal for easier comparison
    $startvaluedec = [Convert]::ToInt32($hexstartvalue, 16)

    if($hexendvalue){
    
        $endvaluedec = [Convert]::ToInt32($hexendvalue, 16)
    
        #Cheking existence in range
        if($decimal -in ($startvaluedec..$endvaluedec)){
        
            $line.scriptname -replace '\#.*$'

            break

            }
        }
    
    else{
    
        #Checking equality with single value (in case it is not a range)
        if($decimal -like $startvaluedec){
        
            $line.scriptname -replace '\#.*$'
            
            break

            }
    
        }
    }

}