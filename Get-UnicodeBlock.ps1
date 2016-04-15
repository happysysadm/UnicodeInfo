function Get-UnicodeBlock {

<#
.SYNOPSIS
    Get the Block property of a Unicode glyph.
.DESCRIPTION
    Get-UnicodeBlock is a PowerShell function that queries the Unicde DataBase (UDB) for information
    on the Block property of a given glyph. It requires an Internet connection to download the UDB.
.PARAMETER Glyph
    A Unicode glyph.
.EXAMPLE
     Get-UnicodeBlock -Glyph 'Ω'
.EXAMPLE
     '£' | Get-UnicodeBlock
.NOTES
    Author:  Carlo MANCINI
    Website: http://www.happysysadm.com
    Twitter: @sysadm2010
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,ValueFromPipeline=$True)][char]$glyph
    )
    
if(!$blockslist) {

    $sourceblocks = "http://www.unicode.org/Public/UNIDATA/Blocks.txt"

    $blocksweb = Invoke-WebRequest $sourceblocks

    $global:blocklist = (($blocksweb.content.split("`n").trim() -ne "") | sls "^#" -n | convertfrom-csv -Delimiter ';' -header "range","blockname").blockname

    }

foreach($block in $blocklist){

    $block = $block -replace ' ',''

    $regex = "(?=\p{Is$block})"

    try{

        if($glyph  -match $regex)

            {
            
            $block

            break

            }

        }

    catch{}

    }

}