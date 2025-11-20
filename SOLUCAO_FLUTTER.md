# 🔧 Solução: Flutter não encontrado

## Problema
O erro `flutter não é reconhecido` significa que o Flutter não está no PATH do sistema.

## ✅ Soluções Rápidas

### Opção 1: Usar os Scripts Criados

Execute um dos scripts criados:

**PowerShell:**
```powershell
.\executar.ps1
```

**CMD/Batch:**
```cmd
executar.bat
```

Os scripts tentam encontrar o Flutter automaticamente!

### Opção 2: Adicionar Flutter ao PATH

1. **Encontre onde o Flutter está instalado:**
   - Procure por uma pasta chamada `flutter` no seu computador
   - Locais comuns:
     - `C:\src\flutter`
     - `C:\flutter`
     - `%LOCALAPPDATA%\flutter`
     - `%USERPROFILE%\flutter`

2. **Adicione ao PATH:**
   - Pressione `Win + R`
   - Digite: `sysdm.cpl` e pressione Enter
   - Clique em **Avançado** → **Variáveis de Ambiente**
   - Em **Variáveis do sistema**, encontre **Path** e clique em **Editar**
   - Clique em **Novo** e adicione: `C:\src\flutter\bin` (ou o caminho onde está)
   - Clique em **OK** em todas as janelas
   - **Reinicie o terminal/PowerShell**

3. **Verifique:**
   ```powershell
   flutter --version
   ```

### Opção 3: Usar Caminho Completo

Se você sabe onde o Flutter está, use o caminho completo:

```powershell
C:\src\flutter\bin\flutter.bat pub get
C:\src\flutter\bin\flutter.bat run
```

### Opção 4: Instalar Flutter

Se o Flutter não está instalado:

1. **Baixe o Flutter:**
   - Acesse: https://flutter.dev/docs/get-started/install/windows
   - Baixe o arquivo ZIP

2. **Extraia:**
   - Extraia para `C:\src\flutter` (ou outro local)

3. **Adicione ao PATH** (siga a Opção 2)

4. **Verifique a instalação:**
   ```powershell
   flutter doctor
   ```

## 🎯 Verificação Rápida

Execute no PowerShell para verificar se o Flutter está acessível:

```powershell
# Verifica se está no PATH
Get-Command flutter -ErrorAction SilentlyContinue

# Procura em locais comuns
Get-ChildItem -Path "C:\" -Filter "flutter.bat" -Recurse -ErrorAction SilentlyContinue -Depth 3 | Select-Object -First 5 FullName
```

## 📝 Próximos Passos

Depois de resolver o problema do PATH:

1. **Instale dependências:**
   ```powershell
   flutter pub get
   ```

2. **Verifique dispositivos:**
   ```powershell
   flutter devices
   ```

3. **Execute o app:**
   ```powershell
   flutter run
   ```

## 💡 Dica

Se você usa Android Studio ou VS Code, pode executar o projeto diretamente de lá sem precisar do PATH configurado!

