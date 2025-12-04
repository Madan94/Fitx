@echo off
set GRADLE_OPTS=-Dcom.sun.net.ssl.checkRevocation=false
set JAVA_OPTS=-Dcom.sun.net.ssl.checkRevocation=false
cd /d "%~dp0"
flutter run

