@echo off
REM ===========================================================================
REM  Local preview server for the portfolio.
REM
REM  Why this exists:
REM    Browsers block fetch() of local files when a page is opened with the
REM    file:// protocol, so index.html cannot read Home.json / Projects.json /
REM    Blog.json if you just double-click it. Serving the folder over HTTP
REM    fixes that, and this script picks whatever server you already have.
REM
REM  Usage:  preview.cmd            (serves on http://localhost:8000)
REM          preview.cmd 3000       (serves on http://localhost:3000)
REM ===========================================================================

setlocal
set PORT=%1
if "%PORT%"=="" set PORT=8000
set URL=http://localhost:%PORT%

echo.
echo   Portfolio local preview
echo   -----------------------
echo   Serving:  %URL%
echo   Stop:     Ctrl+C
echo.

where python >nul 2>nul
if %errorlevel% equ 0 (
    start "" "%URL%"
    python -m http.server %PORT%
    goto :done
)

where py >nul 2>nul
if %errorlevel% equ 0 (
    start "" "%URL%"
    py -m http.server %PORT%
    goto :done
)

where npx >nul 2>nul
if %errorlevel% equ 0 (
    start "" "%URL%"
    npx --yes serve -l %PORT% .
    goto :done
)

echo   Could not find python, py or npx.
echo   Install Python 3 or Node.js, then run preview.cmd again.
echo   Or just open the live site:
echo     https://cjanithwaduge.github.io/Project_Portfolio/
echo.
pause

:done
endlocal
