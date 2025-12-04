# Gradle SSL Certificate Fix

## Quick Fix: Manual Download

1. Download Gradle 8.14 manually from:
   https://services.gradle.org/distributions/gradle-8.14-all.zip

2. Extract and place it in:
   `C:\Users\<YourUsername>\.gradle\wrapper\dists\gradle-8.14-all\<hash>\gradle-8.14-all\`

   Or run this PowerShell command (replace `<hash>` with the actual hash folder name that Gradle creates):
   ```powershell
   $gradleCacheDir = "$env:USERPROFILE\.gradle\wrapper\dists\gradle-8.14-all"
   New-Item -ItemType Directory -Force -Path $gradleCacheDir | Out-Null
   # After downloading, place the zip file here and extract it
   ```

## Alternative: Use System Java Certificates

If you have admin access, you can import certificates into Java's truststore:

```powershell
# Find your Java installation
$javaHome = $env:JAVA_HOME
if (-not $javaHome) {
    $javaHome = (Get-Command java).Source | Split-Path | Split-Path
}

# Import Windows root certificates (requires admin)
$keytool = "$javaHome\bin\keytool.exe"
# This would require exporting certificates from Windows certificate store
```

## Temporary Workaround: Use HTTP (Development Only)

Edit `gradle/wrapper/gradle-wrapper.properties` and change:
```
distributionUrl=http\://services.gradle.org/distributions/gradle-8.14-all.zip
```

**Warning**: This is insecure and should only be used in development environments.



