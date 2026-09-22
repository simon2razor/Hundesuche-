@echo off
echo ===================================================
echo 🚨 HUNDESUCHE (LEO) WIRD GESTARTET 🚨
echo ===================================================
echo.
cd hundesuche-main

echo 1. Pruefe Node.js-Abhaengigkeiten...
call npm ci
call npx playwright install chromium

echo.
echo 2. Starte Radar-Hintergrundprozess...
set NTFY_TOPIC=leo_radar_suche_oberbayern
set DOG_NAME=Leo
set REPORT_PATH=..\report.html

:: Startet den Scanner im Hintergrund, der alle 60 Minuten sucht
start "Hundesuche Leo" cmd /k "python scanner.py --loop 60"

echo.
echo 3. Oeffne die Ergebnisseite im Browser...
:: Wartet kurz, damit report.html beim allerersten Start erstellt werden kann
timeout /t 5 >nul
if exist "..\report.html" (
    start "" "..\report.html"
) else (
    echo [Info] Der Report wird erstellt, sobald der erste Suchlauf fertig ist.
)

echo.
echo ===================================================
echo Das System laeuft nun vollautomatisch im neuen Fenster!
echo Du bekommst Push-Nachrichten ueber ntfy auf den Kanal:
echo leo_radar_suche_oberbayern
echo ===================================================
pause
