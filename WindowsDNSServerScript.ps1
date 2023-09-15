$count = 0
while ($true) {
    Clear-DNSServerCache -Force
    Start-Sleep -Seconds 3
    $count++
    Write-Host "Cleared the cache ${count} time(s)"
}