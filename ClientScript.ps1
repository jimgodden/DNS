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

    $maxCount = 20 # can be increased up to 20
    $count = 0
    while ($true) {
        for ($i = 1; $i -le $maxCount; $i++) {
            $dnsResolution = (Resolve-DnsName -DnsOnly -Server $DNSServerIP "${i}.godden.me").ipaddress
            if ($dnsResolution -eq "10.0.0.2") {
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
        Write-Host "Private IP Address Provided by ${DNSServerIP} ${count} times"
        Start-Sleep -Seconds 5
    }
}


function Test-DNS {
    param (
        $DNSServerIP
    )
    $fileName = "DNSResults_${DNSServerIP}_$(Get-Date -Format "MM-dd-yyyy_HH-mm").txt"
    $folderPath = "C:\"
    $folderName = "MS_CAPTURE_DATA"
    $filePath = "${folderPath}${folderName}\"

    if (!(Test-Path $filePath)) {
        New-Item -ItemType Directory -Path $folderPath -Name $folderName
    }
    New-Item -ItemType File -Path $filePath -Name $fileName
    
    $goodCount = 0
    $badCount = 0
    while ($true) {
        for ($i = 1; $i -le 20; $i++) {
            $dnsResolution = (Resolve-DnsName -DnsOnly -Server $DNSServerIP "${i}.godden.me").ipaddress
            if ($dnsResolution -eq "10.0.0.2") {
                $timestamp = "$(Get-Date)"
                $content = "IP Address ${dnsResolution} was provided for ${i}.godden.me by ${DNSServerIP}."
        
                Write-Host $timestamp
                $timestamp | Out-File -FilePath "${filePath}${fileName}" -Append
                Write-Host $content
                $content | Out-File -FilePath "${filePath}${fileName}" -Append
                $badCount++
            }
            elseif ($dnsResolution -eq "10.0.0.1") {
                $goodCount++
            }
            else {
                $content = "Unknown Error has occured. at $(Get-Date)"
                Write-Host $content
                $content | Out-File -FilePath "${filePath}${fileName}" -Append
            }
        }

        Start-Sleep -Seconds 1

        for ($i = 21; $i -le 40; $i++) {
            $dnsResolution = (Resolve-DnsName -DnsOnly -Server $DNSServerIP "${i}.godden.me").ipaddress
            if ($dnsResolution -eq "10.0.0.2") {
                $timestamp = "$(Get-Date)"
                $content = "IP Address ${dnsResolution} was provided for ${i}.godden.me by ${DNSServerIP}."
        
                Write-Host $timestamp
                $timestamp | Out-File -FilePath "${filePath}${fileName}" -Append
                Write-Host $content
                $content | Out-File -FilePath "${filePath}${fileName}" -Append
                $badCount++
            }
            elseif ($dnsResolution -eq "10.0.0.1") {
                $goodCount++
            }
            else {
                $content = "Unknown Error has occured. at $(Get-Date)"
                Write-Host $content
                $content | Out-File -FilePath "${filePath}${fileName}" -Append
            }
        }

        Start-Sleep -Seconds 1

        for ($i = 41; $i -le 60; $i++) {
            $dnsResolution = (Resolve-DnsName -DnsOnly -Server $DNSServerIP "${i}.godden.me").ipaddress
            if ($dnsResolution -eq "10.0.0.2") {
                $timestamp = "$(Get-Date)"
                $content = "IP Address ${dnsResolution} was provided for ${i}.godden.me by ${DNSServerIP}."
        
                Write-Host $timestamp
                $timestamp | Out-File -FilePath "${filePath}${fileName}" -Append
                Write-Host $content
                $content | Out-File -FilePath "${filePath}${fileName}" -Append
                $badCount++
            }
            elseif ($dnsResolution -eq "10.0.0.1") {
                $goodCount++
            }
            else {
                $content = "Unknown Error has occured. at $(Get-Date)"
                Write-Host $content
                $content | Out-File -FilePath "${filePath}${fileName}" -Append
            }
        }

        Start-Sleep -Seconds 1

        for ($i = 61; $i -le 80; $i++) {
            $dnsResolution = (Resolve-DnsName -DnsOnly -Server $DNSServerIP "${i}.godden.me").ipaddress
            if ($dnsResolution -eq "10.0.0.2") {
                $timestamp = "$(Get-Date)"
                $content = "IP Address ${dnsResolution} was provided for ${i}.godden.me by ${DNSServerIP}."
        
                Write-Host $timestamp
                $timestamp | Out-File -FilePath "${filePath}${fileName}" -Append
                Write-Host $content
                $content | Out-File -FilePath "${filePath}${fileName}" -Append
                $badCount++
            }
            elseif ($dnsResolution -eq "10.0.0.1") {
                $goodCount++
            }
            else {
                $content = "Unknown Error has occured. at $(Get-Date)"
                Write-Host $content
                $content | Out-File -FilePath "${filePath}${fileName}" -Append
            }
        }

        Start-Sleep -Seconds 1

        for ($i = 81; $i -le 100; $i++) {
            $dnsResolution = (Resolve-DnsName -DnsOnly -Server $DNSServerIP "${i}.godden.me").ipaddress
            if ($dnsResolution -eq "10.0.0.2") {
                $timestamp = "$(Get-Date)"
                $content = "IP Address ${dnsResolution} was provided for ${i}.godden.me by ${DNSServerIP}."
        
                Write-Host $timestamp
                $timestamp | Out-File -FilePath "${filePath}${fileName}" -Append
                Write-Host $content
                $content | Out-File -FilePath "${filePath}${fileName}" -Append
                $badCount++
            }
            elseif ($dnsResolution -eq "10.0.0.1") {
                $goodCount++
            }
            else {
                $content = "Unknown Error has occured. at $(Get-Date)"
                Write-Host $content
                $content | Out-File -FilePath "${filePath}${fileName}" -Append
            }
        }
        Write-Host "Private IP Address Provided ${goodCount} times"
        Write-Host "Public IP Address Provided ${badCount} times"
    }
}



$fileName = "DNSResults_$(Get-Date -Format "MM-dd-yyyy_HH-mm").txt"
$folderPath = "C:\"
$folderName = "MS_CAPTURE_DATA"
$filePath = "${folderPath}${folderName}\"
$DNSServerIP = "10.1.5.103"

if (!(Test-Path $filePath)) {
    New-Item -ItemType Directory -Path $folderPath -Name $folderName
}
New-Item -ItemType File -Path $filePath -Name $fileName

$goodCount = 0
$badCount = 0
while ($true) {
    $dnsResolution = (Resolve-DnsName -DnsOnly -Server $DNSServerIP "us-da-datalake-prod-synw0001.sql.azuresynapse.net").ipaddress
    if ($dnsResolution -eq "13.89.169.20") {
        $timestamp = "$(Get-Date)"
        $content = "IP Address ${dnsResolution} was provided for us-da-datalake-prod-synw0001.sql.azuresynapse.net by ${DNSServerIP}."

        Write-Host $timestamp
        $timestamp | Out-File -FilePath "${filePath}${fileName}" -Append
        Write-Host $content
        $content | Out-File -FilePath "${filePath}${fileName}" -Append
        $badCount++
    }
    elseif ($dnsResolution -eq "10.1.14.186") {
        $goodCount++
    }
    else {
        $content = "Unknown Error has occured. at $(Get-Date)"
        Write-Host $content
        $content | Out-File -FilePath "${filePath}${fileName}" -Append
    }

    Write-Host "Private IP Address Provided ${goodCount} times"
    Write-Host "Public IP Address Provided ${badCount} times"
    Start-Sleep -Seconds 5
}

Start-Process PowerShell.exe -arg '-noprofile -noexit ./DNSTest.ps1 ' 