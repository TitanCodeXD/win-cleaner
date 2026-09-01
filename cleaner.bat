@echo off
title win-cleaner v1.0.0
chcp 65001 >nul

:: Cores ANSI para a interface
set "ESC="
for /f %%A in ('echo prompt $E ^| cmd') do set "ESC=%%A"
set "GREEN=%ESC%[92m"
set "CYAN=%ESC%[36m"
set "YELLOW=%ESC%[93m"
set "RED=%ESC%[91m"
set "GRAY=%ESC%[90m"
set "RESET=%ESC%[0m"

:: Código ANSI para mover o cursor para o início da linha anterior
set "MOVE_UP=%ESC%[1A"

:: Verifica permissao de Administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo %RED%[ERRO] Este script precisa ser executado como Administrador!%RESET%
    pause
    exit
)

:: Captura espaco antes da limpeza
for /f %%a in ('powershell -command "(Get-Volume -DriveLetter C).SizeRemaining"') do set "espaco_antes=%%a"

echo %CYAN%===========================================================%RESET%
echo.
echo    %GREEN% WIN-CLEANER :: Otimização do Sistema - made by Wesley%RESET%
echo.
echo %CYAN%===========================================================%RESET%
echo.
echo %GRAY%* Arquivos bloqueados pelo sistema serão ignorados automaticamente.%RESET%
echo.
echo.
echo %YELLOW%Pressione qualquer tecla para iniciar a varredura...%RESET%
pause >nul
echo.
echo %CYAN%---------------------------------------------------%RESET%
echo.

:: ---------------------------------------------------
:: ETAPA 1
:: ---------------------------------------------------
echo %CYAN%Etapa 1 - Arquivos temporários%RESET%
echo %YELLOW%[ WAIT ]%RESET% Limpando arquivos temporários...

del /q /f /s "%temp%\*.*" >nul 2>&1
rmdir /s /q "%temp%" >nul 2>&1
mkdir "%temp%" >nul 2>&1
del /q /f /s "C:\Windows\Temp\*.*" >nul 2>&1
rmdir /s /q "C:\Windows\Temp" >nul 2>&1
mkdir "C:\Windows\Temp" >nul 2>&1
if exist "C:\Temp" (
    del /q /f /s "C:\Temp\*.*" >nul 2>&1
    rmdir /s /q "C:\Temp" >nul 2>&1
    mkdir "C:\Temp" >nul 2>&1
)
timeout /t 1 >nul 2>&1

:: Move para cima e substitui o status na mesma linha
echo %MOVE_UP%%GREEN%[  OK  ]%RESET% Arquivos temporários limpos.             
echo.

:: ---------------------------------------------------
:: ETAPA 2
:: ---------------------------------------------------
echo %CYAN%Etapa 2 - Cache de apps (Spotify/Discord/Navegador/Node.js)%RESET%
echo %YELLOW%[ WAIT ]%RESET% Limpando cache de aplicativos - Spotify/Node.js...

::: [Spotify Oficial]
if exist "%LocalAppData%\Spotify\Data" (
    rmdir /s /q "%LocalAppData%\Spotify\Data" >nul 2>&1
    mkdir "%LocalAppData%\Spotify\Data" >nul 2>&1
)
if exist "%LocalAppData%\Spotify\Storage" (
    rmdir /s /q "%LocalAppData%\Spotify\Storage" >nul 2>&1
    mkdir "%LocalAppData%\Spotify\Storage" >nul 2>&1
)
:: [Spotify Windows Store]
for /d %%i in ("%LocalAppData%\Packages\SpotifyAB.SpotifyMusic_*") do (
    if exist "%%i\LocalState\Spotify\Data" (
        rmdir /s /q "%%i\LocalState\Spotify\Data" >nul 2>&1
        mkdir "%%i\LocalState\Spotify\Data" >nul 2>&1
    )
    if exist "%%i\LocalState\Spotify\Storage" (
        rmdir /s /q "%%i\LocalState\Spotify\Storage" >nul 2>&1
        mkdir "%%i\LocalState\Spotify\Storage" >nul 2>&1
    )
) 2>nul

:: [Discord]
if exist "%AppData%\Discord\Cache" (
    del /q /f /s "%AppData%\Discord\Cache\*.*" >nul 2>&1
)
if exist "%AppData%\Discord\Code Cache" (
    del /q /f /s "%AppData%\Discord\Code Cache\*.*" >nul 2>&1
)

:: [Discord versão PTB, é um discord de versão de testes publicos e etc. É o que eu uso, então acabei colocando]
if exist "%AppData%discordptb\Cache" (
    del /q /f /s "%AppData%\Discord\Cache\*.*" >nul 2>&1
)
if exist "%AppData%\discordptb\Code Cache" (
    del /q /f /s "%AppData%\Discord\Code Cache\*.*" >nul 2>&1
)

:: [Google Chrome que muitos usam, particularmente não uso, mas coloquei porque é comum]
if exist "%LocalAppData%\Google\Chrome\User Data\Default\Cache" (
    del /q /f /s "%LocalAppData%\Google\Chrome\User Data\Default\Cache\*.*" >nul 2>&1
)

:: [Opera GX outro que muitos usam]
if exist "%LocalAppData%\Opera Software\Opera GX Stable\Cache" (
    del /q /f /s "%LocalAppData%\Opera Software\Opera GX Stable\Cache\*.*" >nul 2>&1
)

:: [Node Cache / npm]
if exist "%AppData%\npm-cache" (
    del /q /f /s "%AppData%\npm-cache\*.*" >nul 2>&1
    rmdir /s /q "%AppData%\npm-cache" >nul 2>&1
)
timeout /t 1 >nul 2>&1

echo %MOVE_UP%%GREEN%[  OK  ]%RESET% Caches de aplicativos removidos com sucesso.
echo.

:: ---------------------------------------------------
:: ETAPA 3
:: ---------------------------------------------------
echo %CYAN%Etapa 3 - Otimização de rede%RESET%
echo %YELLOW%[ WAIT ]%RESET% Otimizando rede e logs do sistema...

del /q /f /s "C:\Windows\Prefetch\*.*" >nul 2>&1
rmdir /s /q "C:\Windows\Prefetch" >nul 2>&1
mkdir "C:\Windows\Prefetch" >nul 2>&1
ipconfig /flushdns >nul 2>&1
del /q /f /s "C:\Windows\*.log" >nul 2>&1
timeout /t 1 >nul 2>&1

echo %MOVE_UP%%GREEN%[  OK  ]%RESET% DNS flush executado e logs antigos deletados.
echo.

:: ---------------------------------------------------
:: ETAPA 4
:: ---------------------------------------------------
echo %CYAN%Etapa 4 - Limpando lixeiras%RESET%
echo %YELLOW%[ WAIT ]%RESET% Esvaziando Lixeira do sistema...

powershell -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" >nul 2>&1
timeout /t 1 >nul 2>&1

echo %MOVE_UP%%GREEN%[  OK  ]%RESET% Lixeira limpa de todos os discos.
echo.

:: ---------------------------------------------------
:: ETAPA 5
:: ---------------------------------------------------
echo %CYAN%Etapa 5 - Limpando cache de atualizações do windowns%RESET%
echo %YELLOW%[ WAIT ]%RESET% Limpando cache de atualizações do Windows...

net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
del /f /q /s "C:\Windows\SoftwareDistribution\Download\*.*" >nul 2>&1
rmdir /s /q "C:\Windows\SoftwareDistribution\Download" >nul 2>&1
mkdir "C:\Windows\SoftwareDistribution\Download" >nul 2>&1
net start bits >nul 2>&1
net start wuauserv >nul 2>&1

echo %MOVE_UP%%GREEN%[  OK  ]%RESET% Distribuição de software do Windows Update limpa.
echo.

echo %CYAN%===================================================%RESET%
echo   %GREEN%ANÁLISE DE RESULTADOS%RESET%
echo %CYAN%===================================================%RESET%

:: Bloco PowerShell Calculador com Cores ANSI
powershell -command "$antes = [int64]%espaco_antes%; $depois = (Get-Volume -DriveLetter C).SizeRemaining; $diff = $depois - $antes; if ($diff -le 0) { Write-Host 'Nenhum espaço significativo foi liberado desta vez.' -ForegroundColor Yellow } else { if ($diff -gt 1GB) { $total = '{0:N2} GB' -f ($diff / 1GB) } else { $total = '{0:N2} MB' -f ($diff / 1MB) }; Write-Host '>>> ESPAÇO TOTAL LIBERADO NO DISCO C: ' -NoNewline -ForegroundColor Green; Write-Host $total -ForegroundColor Cyan; }"

echo.
pause
