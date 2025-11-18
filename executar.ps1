# Script para executar o aplicativo Flutter
# Este script tenta encontrar o Flutter automaticamente

Write-Host "=== Executando Aplicativo Flutter ===" -ForegroundColor Cyan
Write-Host ""

# Locais comuns onde o Flutter pode estar instalado
$flutterPaths = @(
    "$env:LOCALAPPDATA\flutter\bin\flutter.bat",
    "C:\src\flutter\bin\flutter.bat",
    "C:\flutter\bin\flutter.bat",
    "$env:USERPROFILE\flutter\bin\flutter.bat",
    "$env:ProgramFiles\flutter\bin\flutter.bat"
)

$flutterPath = $null

# Verifica se o Flutter está no PATH
try {
    $flutterCheck = Get-Command flutter -ErrorAction Stop
    $flutterPath = "flutter"
    Write-Host "✓ Flutter encontrado no PATH" -ForegroundColor Green
} catch {
    Write-Host "✗ Flutter não encontrado no PATH" -ForegroundColor Yellow
    Write-Host "Procurando em locais comuns..." -ForegroundColor Yellow
    
    # Procura nos locais comuns
    foreach ($path in $flutterPaths) {
        if (Test-Path $path) {
            $flutterPath = $path
            Write-Host "✓ Flutter encontrado em: $path" -ForegroundColor Green
            break
        }
    }
}

if ($null -eq $flutterPath) {
    Write-Host ""
    Write-Host "❌ Flutter não foi encontrado!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Opções:" -ForegroundColor Yellow
    Write-Host "1. Instalar Flutter: https://flutter.dev/docs/get-started/install/windows" -ForegroundColor White
    Write-Host "2. Se já instalou, adicione ao PATH do Windows" -ForegroundColor White
    Write-Host "3. Ou informe o caminho completo do Flutter abaixo" -ForegroundColor White
    Write-Host ""
    $customPath = Read-Host "Digite o caminho completo do flutter.bat (ou pressione Enter para sair)"
    
    if ($customPath -and (Test-Path $customPath)) {
        $flutterPath = $customPath
    } else {
        Write-Host "Saindo..." -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "Instalando dependências..." -ForegroundColor Cyan
& $flutterPath pub get

if ($LASTEXITCODE -ne 0) {
    Write-Host "Erro ao instalar dependências!" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Verificando dispositivos disponíveis..." -ForegroundColor Cyan
& $flutterPath devices

Write-Host ""
Write-Host "Executando aplicativo..." -ForegroundColor Cyan
Write-Host "Pressione 'q' para sair quando o app estiver rodando" -ForegroundColor Yellow
Write-Host ""

& $flutterPath run

