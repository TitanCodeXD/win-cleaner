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

echo ===================================================
echo    INICIANDO A SUPER LIMPEZA (MODO RELATORIO)
echo ===================================================
echo.
echo * Arquivos em uso exibirao 'Acesso negado', o que eh normal.
echo.
pause

echo.
echo ---------------------------------------------------
echo [1/7] Limpando arquivos Temp do Usuario (%%temp%%)...
echo ---------------------------------------------------
del /q /f /s "%temp%\*.*"
rmdir /s /q "%temp%"
mkdir "%temp%"

echo.
echo ---------------------------------------------------
echo [2/7] Limpando arquivos Temp do Sistema...
echo ---------------------------------------------------
del /q /f /s "C:\Windows\Temp\*.*"
rmdir /s /q "C:\Windows\Temp"
mkdir "C:\Windows\Temp"

echo.
echo ---------------------------------------------------
echo [3/7] Limpando arquivos do Prefetch...
echo ---------------------------------------------------
del /q /f /s "C:\Windows\Prefetch\*.*"
rmdir /s /q "C:\Windows\Prefetch"
mkdir "C:\Windows\Prefetch"

echo.
echo ---------------------------------------------------
echo [4/7] Limpando o Cache de DNS...
echo ---------------------------------------------------
ipconfig /flushdns

echo.
echo ---------------------------------------------------
echo [5/7] Limpando Arquivos de Log do Windows...
echo ---------------------------------------------------
del /q /f /s "C:\Windows\*.log"

echo.
echo ---------------------------------------------------
echo [6/7] Esvaziando a Lixeira de TODOS os discos...
powershell -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue"

echo [7/7] Limpando Cache do Windows Update...
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
del /f /q /s "C:\Windows\SoftwareDistribution\Download\*.*"
rmdir /s /q "C:\Windows\SoftwareDistribution\Download"
mkdir "C:\Windows\SoftwareDistribution\Download"
net start bits
net start wuauserv


echo.
echo ===================================================
echo    LIMPEZA CONCLUIDA! REVISE OS RESULTADOS ACIMA.
echo ===================================================
echo.
pause