@echo off
REM Script simples para executar o Flutter
REM Tenta encontrar o Flutter automaticamente

echo === Executando Aplicativo Flutter ===
echo.

REM Verifica locais comuns
set FLUTTER_PATH=

if exist "%LOCALAPPDATA%\flutter\bin\flutter.bat" (
    set FLUTTER_PATH=%LOCALAPPDATA%\flutter\bin\flutter.bat
    goto :found
)

if exist "C:\src\flutter\bin\flutter.bat" (
    set FLUTTER_PATH=C:\src\flutter\bin\flutter.bat
    goto :found
)

if exist "C:\flutter\bin\flutter.bat" (
    set FLUTTER_PATH=C:\flutter\bin\flutter.bat
    goto :found
)

REM Tenta usar flutter do PATH
where flutter >nul 2>&1
if %ERRORLEVEL% == 0 (
    set FLUTTER_PATH=flutter
    goto :found
)

echo Flutter nao encontrado!
echo.
echo Por favor, informe o caminho completo do Flutter:
echo Exemplo: C:\src\flutter\bin\flutter.bat
echo.
set /p FLUTTER_PATH="Digite o caminho do flutter.bat: "

if not exist "%FLUTTER_PATH%" (
    echo Caminho invalido!
    pause
    exit /b 1
)

:found
echo Flutter encontrado!
echo.

echo Instalando dependencias...
"%FLUTTER_PATH%" pub get

if %ERRORLEVEL% neq 0 (
    echo Erro ao instalar dependencias!
    pause
    exit /b 1
)

echo.
echo Verificando dispositivos...
"%FLUTTER_PATH%" devices

echo.
echo Executando aplicativo...
echo Pressione Ctrl+C para parar
echo.

"%FLUTTER_PATH%" run

pause

