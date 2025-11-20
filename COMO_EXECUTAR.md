# Como Executar o Programa

## 📋 Pré-requisitos

Antes de executar o aplicativo, você precisa ter:

1. **Flutter instalado** - [Baixar Flutter](https://flutter.dev/docs/get-started/install/windows)
2. **Android Studio** ou **VS Code** com extensões do Flutter
3. **Dispositivo Android/iOS** ou **Emulador** configurado

## 🚀 Passos para Executar

### Opção 1: Usando o Terminal/CMD

1. **Abra o terminal** (PowerShell, CMD ou Git Bash)

2. **Navegue até a pasta do projeto:**
   ```bash
   cd C:\Users\Fabio\OneDrive\Desktop\fluter
   ```

3. **Instale as dependências:**
   ```bash
   flutter pub get
   ```

4. **Verifique dispositivos disponíveis:**
   ```bash
   flutter devices
   ```

5. **Execute o aplicativo:**
   ```bash
   flutter run
   ```

### Opção 2: Usando Android Studio

1. Abra o **Android Studio**
2. Clique em **File → Open**
3. Selecione a pasta `C:\Users\Fabio\OneDrive\Desktop\fluter`
4. Aguarde o Flutter configurar o projeto
5. Clique no botão **Run** (▶️) ou pressione `Shift + F10`

### Opção 3: Usando VS Code

1. Abra o **VS Code**
2. Clique em **File → Open Folder**
3. Selecione a pasta `C:\Users\Fabio\OneDrive\Desktop\fluter`
4. Pressione `F5` ou clique em **Run → Start Debugging**
5. Selecione o dispositivo/emulador

## ⚙️ Configuração da API

**IMPORTANTE:** Antes de executar, configure sua chave da API:

1. Abra o arquivo: `lib/services/servico_clima.dart`
2. Substitua `YOUR_API_KEY_HERE` pela sua chave da OpenWeatherMap
3. Salve o arquivo

```dart
static const String chaveApi = 'sua_chave_aqui';
```

## 🔧 Solução de Problemas

### Flutter não encontrado

Se aparecer erro "flutter não é reconhecido":

1. **Verifique se o Flutter está instalado:**
   - Procure pela pasta do Flutter (geralmente em `C:\src\flutter` ou `C:\flutter`)

2. **Adicione ao PATH:**
   - Pressione `Win + R`
   - Digite: `sysdm.cpl` e pressione Enter
   - Vá em **Avançado → Variáveis de Ambiente**
   - Em **Variáveis do sistema**, edite **Path**
   - Adicione o caminho: `C:\src\flutter\bin` (ou onde o Flutter está)
   - Reinicie o terminal

3. **Ou use o caminho completo:**
   ```bash
   C:\src\flutter\bin\flutter.bat pub get
   C:\src\flutter\bin\flutter.bat run
   ```

### Nenhum dispositivo encontrado

1. **Para Android:**
   - Abra o Android Studio
   - Configure um emulador: **Tools → Device Manager → Create Device**
   - Ou conecte um dispositivo físico via USB com depuração USB ativada

2. **Para iOS (apenas Mac):**
   - Abra o Xcode
   - Configure um simulador: **Xcode → Open Developer Tool → Simulator**

### Erro ao instalar dependências

Execute:
```bash
flutter clean
flutter pub get
```

## 📱 Executar em Dispositivo Físico

### Android:
1. Ative **Opções do Desenvolvedor** no celular
2. Ative **Depuração USB**
3. Conecte via USB
4. Execute `flutter run`

### iOS (apenas Mac):
1. Conecte o iPhone via USB
2. Confie no computador no iPhone
3. Execute `flutter run`

## 🎯 Comandos Úteis

```bash
# Ver dispositivos disponíveis
flutter devices

# Executar em dispositivo específico
flutter run -d <device-id>

# Executar em modo release (otimizado)
flutter run --release

# Limpar cache
flutter clean

# Verificar instalação
flutter doctor
```

## ✅ Verificação Final

Antes de executar, certifique-se de:

- ✅ Flutter instalado e no PATH
- ✅ Dispositivo/emulador configurado
- ✅ Chave da API configurada
- ✅ Dependências instaladas (`flutter pub get`)

