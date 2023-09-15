# Using $start and $end to measure how long it takes for this entire script to run
$start = get-date -UFormat "%s"

$currentTime = Get-Date -Format "HH:mm K"
Write-Host "Starting DNS Test.  Process began at: ${currentTime}"

$count = 0
while ($true) {
    for ($i = 1; $i -le 20; $i++) {
        $dnsResolution = (Resolve-DnsName -DnsOnly -Server "10.1.4.5" "${i}.godden.me").ipaddress
        if ($dnsResolution -ne "10.0.0.1") {
            Write-Host "$(Get-Date)"
            $currentTime = get-date -UFormat "%s"
            $timeTotal = $currentTime - $start
            Write-Host "Total time taken to reproduce the issue: ${timeTotal}"
            Write-Host "IP Address ${dnsResolution} was provided for ${i}.godden.me.  It should have been 10.0.0.1 instead."
            Read-Host "Press any key and enter to acknowledge."
        }
        else {
            $count++
        }
    }
    Write-Host "Private IP Address Provided ${count} times"
    Start-Sleep -Seconds 1
}


function Test-DNS {
    param (
        $DNSServerIP
    )
    # Using $start and $end to measure how long it takes for this entire script to run
    $start = get-date -UFormat "%s"

    $currentTime = Get-Date -Format "HH:mm K"
    Write-Host "Starting DNS Test.  Process began at: ${currentTime}"

    $count = 0
    while ($true) {
        for ($i = 1; $i -le 20; $i++) {
            $dnsResolution = (Resolve-DnsName -DnsOnly -Server $DNSServerIP "${i}.godden.me").ipaddress
            if ($dnsResolution -ne "10.0.0.1") {
                Write-Host "$(Get-Date)"
                $currentTime = get-date -UFormat "%s"
                $timeTotal = $currentTime - $start
                Write-Host "Total time taken to reproduce the issue: ${timeTotal}"
                Write-Host "IP Address ${dnsResolution} was provided for ${i}.godden.me by ${DNSServerIP}."  
                Write-Host "It should have been 10.0.0.1 instead."
                Read-Host "Press any key and enter to acknowledge."
            }
            else {
                $count++
            }
        }
        Write-Host "Private IP Address Provided ${count} times"
        Start-Sleep -Seconds 1
    }
}

# Using $start and $end to measure how long it takes for this entire script to run
$start = get-date -UFormat "%s"

$currentTime = Get-Date -Format "HH:mm K"
Write-Host "Starting DNS Test.  Process began at: ${currentTime}"

$count = 0
while ($true) {
    for ($i = 1; $i -le 20; $i++) {
        $dnsResolution = (Resolve-DnsName -DnsOnly -Server $DNSServerIP "${i}.godden.me").ipaddress
        if ($dnsResolution -ne "10.0.0.1") {
            Write-Host "$(Get-Date)"
            $currentTime = get-date -UFormat "%s"
            $timeTotal = $currentTime - $start
            Write-Host "Total time taken to reproduce the issue: ${timeTotal}"
            Write-Host "IP Address ${dnsResolution} was provided for ${i}.godden.me by ${DNSServerIP}."  
            Write-Host "It should have been 10.0.0.1 instead."
            Read-Host "Press any key and enter to acknowledge."
        }
        else {
            $count++
        }
    }
    Write-Host "Private IP Address Provided ${count} times"
    Start-Sleep -Seconds 1
}
