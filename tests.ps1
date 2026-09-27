. "$PSScriptRoot\calc.ps1"
$failed = 0
function Check($name, $actual, $expected) {
    if ($actual -ne $expected) { Write-Host "FAIL $name : expected $expected, got $actual"; $script:failed++ }
    else { Write-Host "ok   $name" }
}
Check 'sum' (Get-Sum @(1, 2, 3)) 6
Check 'min' (Get-Min @(3, -1, 7, 2)) -1
Check 'average' (Get-Average @(2, 4, 6)) 4
Check 'average rounded' (Get-Average @(1, 2, 2)) 1.67
Check 'median odd' (Get-Median @(5, 1, 3)) 3
Check 'median even' (Get-Median @(4, 1, 3, 2)) 2.5
Check 'max' (Get-Max @(3, -1, 7, 2)) 7
Check 'max all negative' (Get-Max @(-5, -2, -9)) -2
Check 'max single' (Get-Max @(4)) 4
Check 'max decimals' (Get-Max @(1.5, 1.25, 1.75)) 1.75
Check 'max duplicates' (Get-Max @(7, 3, 7)) 7
Check 'sum empty' (Get-Sum @()) 0
function CheckThrows($name, [scriptblock]$block) {
    try { & $block; Write-Host "FAIL $name : expected an error"; $script:failed++ }
    catch { Write-Host "ok   $name" }
}
CheckThrows 'max empty throws' { Get-Max @() }
CheckThrows 'min empty throws' { Get-Min @() }
CheckThrows 'average empty throws' { Get-Average @() }
CheckThrows 'median empty throws' { Get-Median @() }

. "$PSScriptRoot\discombobulator.ps1"
$phrase = 'The discombobulator scrambles everything, quickly!'
$mixed = Invoke-Discombobulator $phrase -Seed 42
Check 'discombobulate keeps length' $mixed.Length $phrase.Length
Check 'discombobulate same seed' (Invoke-Discombobulator $phrase -Seed 42) $mixed
Check 'discombobulate changes text' ($mixed -cne $phrase) $true
Check 'discombobulate short words' (Invoke-Discombobulator 'a cat is on it' -Seed 1) 'a cat is on it'
Check 'discombobulate empty' (Invoke-Discombobulator '' -Seed 1) ''
$origWords = $phrase -split ' '
$mixedWords = $mixed -split ' '
$edgesKept = $true; $lettersKept = $true
for ($i = 0; $i -lt $origWords.Count; $i++) {
    $a = $origWords[$i]; $b = $mixedWords[$i]
    if ($a[0] -cne $b[0] -or $a[-1] -cne $b[-1]) { $edgesKept = $false }
    if ((-join ($a.ToCharArray() | Sort-Object)) -cne (-join ($b.ToCharArray() | Sort-Object))) { $lettersKept = $false }
}
Check 'discombobulate keeps first and last' $edgesKept $true
Check 'discombobulate keeps letters' $lettersKept $true

. "$PSScriptRoot\baka-baka-moana.ps1"
$chant = New-BakaBakaMoana -Seed 7
$parts = $chant -split '-'
Check 'baka shape' ($chant -cmatch '^[a-z]{4}-[a-z]{4}-[a-z]{5}$') $true
Check 'baka repeats first word' $parts[1] $parts[0]
Check 'baka ends in a' $parts[2][-1] 'a'
Check 'baka same seed' (New-BakaBakaMoana -Seed 7) $chant
Check 'baka count' @(New-BakaBakaMoana -Seed 7 -Count 5).Count 5
if ($failed) { Write-Host "$failed failed"; exit 1 }
Write-Host 'all passed'
Write-Host 'tests finished'
