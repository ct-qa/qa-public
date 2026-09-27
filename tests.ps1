. "$PSScriptRoot\calc.ps1"
$failed = 0
function Check($name, $actual, $expected) {
    if ($actual -ne $expected) { Write-Host "FAIL $name : expected $expected, got $actual"; $script:failed++ }
    else { Write-Host "ok   $name" }
}
Check 'sum' (Get-Sum @(1, 2, 3)) 6
Check 'average' (Get-Average @(2, 4, 6)) 4
Check 'average rounded' (Get-Average @(1, 2, 2)) 1.67
Check 'median odd' (Get-Median @(5, 1, 3)) 3
Check 'median even' (Get-Median @(4, 1, 3, 2)) 2.5
if ($failed) { Write-Host "$failed failed"; exit 1 }
Write-Host 'all passed'
