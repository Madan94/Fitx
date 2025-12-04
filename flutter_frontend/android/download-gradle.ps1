$ErrorActionPreference = "Stop"

$gradleVersion = "8.14"
$gradleUrl = "https://services.gradle.org/distributions/gradle-${gradleVersion}-all.zip"
$userHome = $env:USERPROFILE
$gradleCacheDir = "$userHome\.gradle\wrapper\dists\gradle-${gradleVersion}-all"
$zipFile = "$gradleCacheDir\gradle-${gradleVersion}-all.zip"

Write-Host "Creating Gradle cache directory..."
New-Item -ItemType Directory -Force -Path $gradleCacheDir | Out-Null

Write-Host "Downloading Gradle ${gradleVersion}..."
try {
    Add-Type @"
        using System.Net;
        using System.Security.Cryptography.X509Certificates;
        public class TrustAllCertsPolicy : ICertificatePolicy {
            public bool CheckValidationResult(
                ServicePoint srvPoint, X509Certificate certificate,
                WebRequest request, int certificateProblem) {
                return true;
            }
        }
"@
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12 -bor [System.Net.SecurityProtocolType]::Tls13 -bor [System.Net.SecurityProtocolType]::Ssl3
    [System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
    [System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
    
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri $gradleUrl -OutFile $zipFile -UseBasicParsing
    Write-Host "Download complete: $zipFile"
    Write-Host "Extracting..."
    Expand-Archive -Path $zipFile -DestinationPath $gradleCacheDir -Force
    Write-Host "Gradle ${gradleVersion} ready!"
} catch {
    Write-Host "Error: $_"
    Write-Host "Trying alternative method..."
    try {
        $webClient = New-Object System.Net.WebClient
        $webClient.DownloadFile($gradleUrl, $zipFile)
        Write-Host "Download complete: $zipFile"
        Write-Host "Extracting..."
        Expand-Archive -Path $zipFile -DestinationPath $gradleCacheDir -Force
        Write-Host "Gradle ${gradleVersion} ready!"
    } catch {
        Write-Host "Error: $_"
        Write-Host "You may need to manually download from: $gradleUrl"
        Write-Host "Save it to: $zipFile"
        exit 1
    }
}

