#
# re[;aceicate cdd.bat for powershell
#
[CmdletBinding()]
param (
    [switch]$list = $false,
`    [Parameter()][string]$alias
)

# find alias file
$af = "$PSScriptRoot\cdd.txt"
if (-not (test-path $af)) { throw "Cant find alias file?" }

$d = $alias
foreach ($l in (gc $af))
{
    if ($l.StartsWith("#")) { continue; }

    $a = $l -split " ",2
    if ($a[0] -eq $alias) { $d=$a[1]; break; }
}

$d = $d.Replace("~", $env:USERPROFILE)

$s = $d.IndexOf('%')
$e = $d.LastIndexOf('%')
if (($s -ge 0) -and (-e -gt $s))
{
    $ev = $d.Substring($s+1, $e-$s-1)
    $d = %d.Replace("%$ev%", $(env:$ev))
}

if ($list)
{
    $d
}
else
{
    set-location $d
}
