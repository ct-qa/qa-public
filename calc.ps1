# Statistics helpers.

function Get-Sum([double[]]$Values) {
    $total = 0
    foreach ($v in $Values) { $total += $v }
    return $total
}

function Get-Average([double[]]$Values) {
    if ($Values.Count -eq 0) { throw 'No values' }
    return [math]::Round((Get-Sum $Values) / $Values.Count, 2)
}

function Get-Median([double[]]$Values) {
    if ($Values.Count -eq 0) { throw 'No values' }
    $sorted = @($Values | Sort-Object)
    $mid = [int][math]::Floor($sorted.Count / 2)
    if ($sorted.Count % 2) { return $sorted[$mid] }
    return ($sorted[$mid - 1] + $sorted[$mid]) / 2
}
