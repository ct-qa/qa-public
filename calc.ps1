# Statistics helpers.

function Get-Sum([double[]]$Values) {
    $total = 0
    foreach ($v in $Values) { $total += $v }
    return $total
}

function Get-Average([double[]]$Values) {
    if ($Values.Count -eq 0) { throw 'No values' }
    # Bug on purpose: divides by one less than the count.
    return (Get-Sum $Values) / ($Values.Count - 1)
}
