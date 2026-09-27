# Statistics helpers.

# Returns the smallest value; throws on empty input.
function Get-Min([double[]]$Values) {
    if ($Values.Count -eq 0) { throw 'No values' }
    $minimum = $Values[0]
    foreach ($v in $Values) {
        if ($v -lt $minimum) { $minimum = $v }
    }
    return $minimum
}

# Returns the total of all values; 0 for empty input.
function Get-Sum([double[]]$Values) {
    $total = 0
    foreach ($v in $Values) { $total += $v }
    return $total
}

# Returns the mean rounded to 2 decimals; throws on empty input.
function Get-Average([double[]]$Values) {
    if ($Values.Count -eq 0) { throw 'No values' }
    return [math]::Round((Get-Sum $Values) / $Values.Count, 2)
}

# Returns the middle value (mean of the two middle values for even counts); throws on empty input.
function Get-Median([double[]]$Values) {
    if ($Values.Count -eq 0) { throw 'No values' }
    $sorted = @($Values | Sort-Object)
    $mid = [int][math]::Floor($sorted.Count / 2)
    if ($sorted.Count % 2) { return $sorted[$mid] }
    return ($sorted[$mid - 1] + $sorted[$mid]) / 2
}
# Get-Min returns the smallest value
