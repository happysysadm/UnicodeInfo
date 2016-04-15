function Get-UnicodeName {

<#
.SYNOPSIS
    Get the Name property of a Unicode glyph.
.DESCRIPTION
    Get-UnicodeName is a PowerShell function that queries the Unicde DataBase (UDB) for information
    on the Name property of a given glyph. It requires an Internet connection to download the UDB.
.PARAMETER Glyph
    A Unicode glyph.
.EXAMPLE
     Get-UnicodeName -Glyph 'Ω'
.EXAMPLE
     '£' | Get-UnicodeName
.NOTES
    Author:  Carlo MANCINI
    Website: http://www.happysysadm.com
    Twitter: @sysadm2010
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,ValueFromPipeline=$True)][char]$Glyph
    )

if(!$namessinfo) { 

    $sourcenames = "http://www.unicode.org/Public/UNIDATA/UnicodeData.txt"

    $namesweb = Invoke-WebRequest $sourcenames

    $global:namessinfo = ($namesweb.content.split("`n").trim() -ne "") |

                convertfrom-csv -Delimiter ';' -header "code point","name"

    }

foreach($line in $namessinfo){

    if(('{0:X4}' -f [int][char]$glyph) -eq $line."code point"){
        
            $line.name

            break
        
            }
    
        }

}