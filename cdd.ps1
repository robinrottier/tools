#
# re[;aceicate cdd.bat for powershell
#
[CmdletBinding()]
param (
    [switch]$list = $false,
	[switch]$listAll = $false,
`    [Parameter()][string]$alias
)

# find alias file
$af = "$PSScriptRoot\cdd.txt"
if (-not (test-path $af)) { throw "Cant find alias file?" }

if ($listAll)
{
	gc $af
	return
}

$d = $alias
$found = $false
foreach ($l in (gc $af))
{
    if ($l.StartsWith("#")) { continue; }

    $a = $l -split " ",2
    if ($a[0] -eq $alias) { $d=$a[1]; $found=$true; break; }
}

if ($found)
{
	$d = $d.Replace("~", $env:USERPROFILE)

	$s = $d.IndexOf('%')
	$e = $d.LastIndexOf('%')
	if (($s -ge 0) -and ($e -gt $s))
	{
		$ev = $d.Substring($s+1, $e-$s-1)
		$evv = (gci env: | ?{ $_.name -eq $ev }).value
		## "$ev = $evv"
		$d = $d.Replace("%$ev%", $evv)
	}
}

if (-not $found)
{
	foreach ($dp in ("$env:USERPROFILE", "$env:USERPROFILE\source\repos"))
	{
		$da = "$dp\$d"
		if (test-path $da)
		{
			$d = $da
			$found = $true
			break;
		}
	}
}

if ($list)
{
    $d
}
else
{
	if (test-path $d)
	{
		set-location $d
	}
	else
	{
		"Cant find $d"
	}
}
