# Clima App - CRUD Flutter

Aplicativo Flutter desenvolvido em Dart para gerenciar locais e consultar informações meteorológicas em tempo real.

## 📱 Funcionalidades

- **CRUD Completo**: Criar, ler, atualizar e excluir locais (cidade e estado)
- **Consulta de Clima**: Obter temperatura atual do dia
- **Informações de Umidade**: Visualizar percentual de umidade do ar
- **Interface Moderna**: Design com Material Design 3
- **Armazenamento Local**: Dados persistidos com SharedPreferences
- **Atualização Manual**: Botão para atualizar dados do clima

## 🚀 Configuração Inicial

### Passo 1: Obter Chave da API OpenWeatherMap

1. Acesse [OpenWeatherMap API](https://openweathermap.org/api)
2. Crie uma conta gratuita (plano Free disponível)
3. Acesse sua dashboard e copie sua API Key
4. Abra o arquivo `lib/services/servico_clima.dart`
5. Substitua `YOUR_API_KEY_HERE` pela sua chave:

```dart
static const String chaveApi = 'sua_chave_aqui';
```

### Passo 2: Instalar Dependências

Execute no terminal:

```bash
flutter pub get
```

### Passo 3: Executar o Aplicativo

```bash
flutter run
```

## 📁 Estrutura do Projeto

```
lib/
├── main.dart                          # Ponto de entrada da aplicação
├── models/
│   ├── localizacao.dart              # Modelo de dados para localização
│   └── clima.dart                    # Modelo de dados para clima
├── services/
│   └── servico_clima.dart            # Serviço de integração com API
├── providers/
│   └── provedor_localizacao.dart     # Gerenciamento de estado (Provider)
└── screens/
    ├── tela_inicial.dart             # Tela principal com lista de locais
    ├── tela_formulario_local.dart    # Formulário para adicionar/editar local
    └── tela_detalhes_clima.dart      # Tela de detalhes do clima
```

## 📦 Dependências

| Pacote | Versão | Descrição |
|--------|--------|-----------|
| `http` | ^1.1.0 | Requisições HTTP para API |
| `provider` | ^6.1.1 | Gerenciamento de estado |
| `shared_preferences` | ^2.2.2 | Armazenamento local de dados |

## 💡 Como Usar

### Adicionar Novo Local
1. Toque no botão **+** (FloatingActionButton) na tela principal
2. Preencha o nome da cidade
3. Preencha a sigla do estado (ex: SP, RJ, MG)
4. Toque em **Adicionar**

### Visualizar Clima
1. Na lista de locais, toque em qualquer item
2. A tela de detalhes exibirá:
   - Temperatura atual em Celsius
   - Descrição do clima
   - Ícone representativo
   - Percentual de umidade

### Editar Local
1. Toque no ícone de **editar** (lápis) ao lado do local
2. Modifique os campos desejados
3. Toque em **Atualizar**

### Excluir Local
1. Toque no ícone de **excluir** (lixeira) ao lado do local
2. Confirme a exclusão no diálogo
3. O local será removido permanentemente

### Atualizar Dados do Clima
1. Na tela de detalhes do clima
2. Toque no ícone de **atualizar** (refresh) na barra superior
3. Os dados serão recarregados da API

## 🔧 Tecnologias Utilizadas

- **Flutter**: Framework multiplataforma
- **Dart**: Linguagem de programação
- **Provider**: Padrão de gerenciamento de estado
- **HTTP**: Comunicação com API REST
- **SharedPreferences**: Persistência de dados local

## 📝 Notas Importantes

- A API OpenWeatherMap oferece plano gratuito com limite de 60 requisições por minuto
- Os dados dos locais são salvos localmente no dispositivo
- O aplicativo tenta buscar o clima primeiro com cidade e estado, depois apenas com a cidade
- Requer conexão com internet para consultar dados do clima
- A chave da API deve ser configurada antes de usar o aplicativo

## 🐛 Solução de Problemas

### Erro ao buscar clima
- Verifique se a chave da API está configurada corretamente
- Confirme se há conexão com internet
- Verifique se o nome da cidade e estado estão corretos

### Dados não aparecem
- Certifique-se de que adicionou pelo menos um local
- Verifique se a API está respondendo corretamente
- Tente atualizar os dados manualmente

## 📄 Licença

Este projeto é de código aberto e está disponível para uso livre.
