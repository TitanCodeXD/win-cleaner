@echo off
title Super Limpeza e Otimizacao (Modo Relatorio)
color 0A

:: Verifica se esta rodando como Administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERRO] Voce PRECISA executar este script como Administrador!
    echo Clique com o botao direito no arquivo e escolha 'Executar como Administrador'.
    pause
    exit
)

:: Captura o espaco livre ANTES da limpeza (via PowerShell)
for /f %%a in ('powershell -command "(Get-Volume -DriveLetter C).SizeRemaining"') do set "espaco_antes=%%a"

echo ===================================================
echo    INICIANDO A SUPER LIMPEZA (MODO RELATORIO)
echo ===================================================
echo.
echo * Arquivos em uso exibirao 'Acesso negado', o que eh normal.
echo.
pause

echo.
echo ---------------------------------------------------
echo [1/10] Limpando arquivos Temp do Usuario (%%temp%%)...
echo ---------------------------------------------------
del /q /f /s "%temp%\*.*"
rmdir /s /q "%temp%"
mkdir "%temp%"

echo.
echo ---------------------------------------------------
echo [2/10] Limpando arquivos Temp do Sistema...
echo ---------------------------------------------------
del /q /f /s "C:\Windows\Temp\*.*"
rmdir /s /q "C:\Windows\Temp"
mkdir "C:\Windows\Temp"

echo.
echo ---------------------------------------------------
echo [3/10] Limpando a pasta C:\Temp (Instaladores antigos)...
echo ---------------------------------------------------
if exist "C:\Temp" (
    del /q /f /s "C:\Temp\*.*"
    rmdir /s /q "C:\Temp"
    mkdir "C:\Temp"
)

echo.
echo ---------------------------------------------------
echo [4/10] Limpando o Cache do Spotify (Data e Storage)...
echo ---------------------------------------------------
if exist "%LocalAppData%\Spotify\Data" (
    del /q /f /s "%LocalAppData%\Spotify\Data\*.*"
)
if exist "%LocalAppData%\Spotify\Storage" (
    del /q /f /s "%LocalAppData%\Spotify\Storage\*.*"
)
for /d %%i in ("%LocalAppData%\Packages\SpotifyAB.SpotifyMusic_*") do (
    if exist "%%i\LocalState\Spotify\Data" (
        del /q /f /s "%%i\LocalState\Spotify\Data\*.*"
    )
    if exist "%%i\LocalState\Spotify\Storage" (
        del /q /f /s "%%i\LocalState\Spotify\Storage\*.*"
    )
)

echo.
echo ---------------------------------------------------
echo [5/10] Limpando o npm-cache (Node.js)...
echo ---------------------------------------------------
if exist "%AppData%\npm-cache" (
    del /q /f /s "%AppData%\npm-cache\*.*"
    rmdir /s /q "%AppData%\npm-cache"
)

echo.
echo ---------------------------------------------------
echo [6/10] Limpando arquivos do Prefetch...
echo ---------------------------------------------------
del /q /f /s "C:\Windows\Prefetch\*.*"
rmdir /s /q "C:\Windows\Prefetch"
mkdir "C:\Windows\Prefetch"

echo.
echo ---------------------------------------------------
echo [7/10] Limpando o Cache de DNS...
echo ---------------------------------------------------
ipconfig /flushdns

echo.
echo ---------------------------------------------------
echo [8/10] Limpando Arquivos de Log do Windows...
echo ---------------------------------------------------
del /q /f /s "C:\Windows\*.log"

echo.
echo ---------------------------------------------------
echo [9/10] Esvaziando a Lixeira de TODOS os discos...
echo ---------------------------------------------------
powershell -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue"

echo.
echo ---------------------------------------------------
echo [10/10] Limpando Cache do Windows Update...
echo ---------------------------------------------------
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
del /f /q /s "C:\Windows\SoftwareDistribution\Download\*.*"
rmdir /s /q "C:\Windows\SoftwareDistribution\Download"
mkdir "C:\Windows\SoftwareDistribution\Download"
net start bits >nul 2>&1
net start wuauserv >nul 2>&1

echo.
echo ===================================================
echo    LIMPEZA CONCLUIDA! REVISE OS RESULTADOS ACIMA.
echo ===================================================
echo.

:: Bloco do PowerShell em linha unica para evitar quebras e erros de sintaxe
powershell -command "$antes = [int64]%espaco_antes%; $depois = (Get-Volume -DriveLetter C).SizeRemaining; $diff = $depois - $antes; if ($diff -le 0) { Write-Host 'Nenhum espaco significativo foi liberado desta vez.' -ForegroundColor Yellow } else { if ($diff -gt 1GB) { $total = '{0:N2} GB' -f ($diff / 1GB) } else { $total = '{0:N2} MB' -f ($diff / 1MB) }; Write-Host '>>> ESPACO TOTAL LIBERADO NO DISCO C: ' -NoNewline -ForegroundColor Green; Write-Host $total -ForegroundColor Cyan; }"

echo.
pause