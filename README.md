# UnicodeInfo

Powershell module to query the Unicode database which is available online at http://www.unicode.org/ucd

#How to install it ?

In order to install it, just downlooad the zip from Github and extract it in your Powershell Module Path, then modify the UnicodeInfo.psm1 to reflect your configuration.

#What functions are available ?

Right now there are 4 property-specific functions:

- Get-UnicodeBlock
- Get-UnicodeName
- Get-UnicodeScript
- Get-UnicodeVersion

and one main function:
- Get-UnicodeInfo

#How to use it

Get-UnicodeInfo is an advanced function which can be queried with Get-Help.

#What if I wan to know more

Head over to powershell.org or to my blog (http://www.happysysadm.com/2016/04/working-with-unicode-scripts-blocks-and.html) for a deep explanation of Unicode character properties.
