function Get-UnicodeInfo {

<#
.SYNOPSIS
    Get the main properties of all the Unicode glyphs in a string.
.DESCRIPTION
    Get-UnicodeInfo is a PowerShell function that queries the Unicde DataBase (UDB) for information
    on each glyph in a given string. It requires an Internet connection to download the UDB.
.PARAMETER String
    A text string of one or more characters.
.EXAMPLE
     Get-UnicodeInfo -String 'Ω'
.EXAMPLE
     Get-UnicodeInfo -String 'abcde'
.EXAMPLE
     Get-UnicodeInfo -String '@' 
.EXAMPLE
     '£¶¾ΨӜ' | Get-UnicodeInfo
.EXAMPLE
     '£¶¾ΨӜ' | Get-UnicodeInfo | Format-Table
.NOTES
    Author:  Carlo MANCINI
    Website: http://www.happysysadm.com
    Twitter: @sysadm2010
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,ValueFromPipeline=$True)][string[]]$string
    )

$string.ToCharArray() | 

ForEach-Object {

        Write-Verbose -Message "Working on $_"

        [PSCustomObject]@{
        
	        Glyph=$_;
        
        	'Decimal value' = [int][char]$_;
        
        	'Hexadecimal value' = 'U+{0:X4}' -f [int][char]$_;
        
        	'General Category' = [System.Globalization.CharUnicodeInfo]::GetUnicodeCategory($_);
        
        	'Unicode name' = Get-UnicodeName -Glyph $_;
        
        	'Unicode script' = Get-UnicodeScript -Glyph $_;
        
        	'Unicode block' = Get-UnicodeBlock -Glyph $_;
        
        	'Unicode version' = Get-UnicodeVersion -Glyph $_

        }

    } 

}