# Cinema Challenge - Suíte de Automação de Testes (AWS & AI for QE)

Este repositório contém a suíte de testes automatizados (API e Web) para a aplicação "Cinema App", desenvolvida como parte do Challenge Técnico do PB AWS & AI for QE.

O projeto demonstra a aplicação de boas práticas de QA, incluindo testes funcionais, de integração, segurança (autorização) e a criação de um fluxo E2E completo, desde o login até a confirmação da reserva.

## 👨‍💻 Sobre Mim (Apresentação Pessoal)

* **Nome:** Guilherme Hepp
* **Idade:** 24 anos
* **Curso:** Ciência da Computação (UFPel)
* **Semestre:** Sétimo Semestre
* **Cidade:** Pelotas - RS
* **Cor de olhos:** Verde
* **Cor de cabelos:** Preto
* **Cor de pele:** Branco

## ✨ Padrões e Boas Práticas Aplicadas

Esta suíte de testes foi construída seguindo padrões de mercado para garantir manutenibilidade, legibilidade e robustez:

* **Page Object Model (Web):** A automação Web (Browser Library) utiliza o padrão Page Objects. Os localizadores (selectors) e as keywords de ação são abstraídos em arquivos de `resource` (ex: `LoginPage.resource`, `SessionPage.resource`), mantendo os testes (`_test.robot`) limpos e focados no fluxo.
* **Service Objects (API):** A automação de API (RequestsLibrary) utiliza um padrão similar, onde as requisições (POST, GET, etc.) são encapsuladas em keywords de alto nível (ex: `Post Login User`), separando a lógica de API dos cenários de teste.
* **Isolamento de Teste (Test Isolation):** Os testes E2E (API e Web) são autossuficientes, criando seus próprios dados (novos filmes, sessões) em tempo de execução para garantir que rodem de forma consistente e evitem falhas por dados "sujos" (ex: assentos já ocupados).
* **Gerenciamento de Dados:** URLs base, credenciais e outros dados sensíveis são armazenados em arquivos de variáveis (ex: `env.resource`) para fácil manutenção.

## 🐞 Principais Issues Encontradas

Durante a análise, foram identificados diversos bugs e melhorias. Os detalhes completos estão no documento `PLANO_DE_TESTES.md` e na aba "Issues" do GitHub.

O bug mais crítico encontrado foi:

* **[BUG-03 - Crítico] Falha de Autorização na API:** Foi verificado que um usuário com a role `user` (comum) consegue executar ações que deveriam ser restritas a `admin`, como resetar os assentos de uma sessão (`PUT /api/v1/sessions/{id}/reset-seats`).

## 📁 Estrutura do Projeto

```
src/
├── API/                    # Automação de Testes da API
│   ├── resources/          # Keywords e Recursos da API
│   ├── tests/             # Casos de Teste da API
│   ├── variables/         # Variáveis Globais
│   └── data/              # Arquivos de Dados de Teste
└── Web/                   # Automação de Testes Web UI
    ├── resources/         # Keywords Web e Page Objects
    └── tests/             # Casos de Teste Web
```

## 📈 Cobertura de Testes da API

* **Autenticação**: Registro, Login (Admin e User), Busca de Perfil.
* **Filmes**: CRUD completo (restrito a Admin).
* **Sessões**: CRUD completo (restrito a Admin).
* **Reservas**: Criação de Reserva (User), Listar Minhas Reservas (User), Listar Todas (Admin).
* **Cinemas**: CRUD completo (restrito a Admin).
* **Usuários**: Listar Usuários (restrito a Admin).
* **Segurança:** Testes de autorização (User vs. Admin) em todas as rotas protegidas.
* **Integração**: Fluxo E2E de API (Admin cria Sessão -> User cria Reserva).

## 🖥️ Cobertura de Testes Web (E2E)

* **Homepage:** Carregamento e verificação de elementos.
* **Autenticação**: Fluxo de Login (sucesso e falha), Fluxo de Cadastro.
* **Filmes**: Navegação, Busca por nome, Filtro por gênero.
* **Perfil**: Navegação e Atualização de nome.
* **Fluxo E2E de Reserva (Crítico):**
    1.  Login
    2.  Navegar para "Filmes em Cartaz"
    3.  Selecionar "Ver Detalhes" de um filme
    4.  Selecionar "Selecionar Assentos" de uma sessão
    5.  Selecionar 2+ assentos no mapa
    6.  Clicar em "Continuar para Pagamento"
    7.  Selecionar "PIX" como método
    8.  Clicar em "Finalizar Compra"
    9.  Validar a mensagem "Reserva Confirmada!"

## ⚙️ Pré-requisitos

* Python 3.8+
* Node.js (para rodar o backend e o frontend da aplicação)
* Navegador Chrome/Chromium (para a Browser Library)

## 🚀 Instalação

1.  Clone o repositório:
    ```bash
    git clone https://github.com/GuilhermeHepp/Compass_Challenge_Final
    cd Compass_Challenge_Final
    ```
2.  Instale as dependências do Python:
    ```bash
    pip install -r requirements.txt
    ```
3.  Instale as dependências da Browser Library (Playwright):
    ```bash
    rfbrowser init
    ```

## 🛠️ Configuração

* **Importante:** Antes de rodar, certifique-se de que as aplicações de **Backend** e **Frontend** estejam rodando em terminais separados!

### Backend
* **URL da API:** `http://localhost:3000/api/v1`
* **Credenciais Admin:** `admin@example.com / password123`
* **Observação:** Certifique-se de que o usuário `admin@example.com` tenha a `role` = `"admin"` no banco de dados MongoDB para que os testes de admin passem.

### Frontend
* **URL Base:** `http://localhost:3002` (Ajuste a URL no arquivo `src/Web/resources/env.resource` se for diferente)
* **Navegador:** Chromium (padrão)

## ⚡ Executando os Testes

### Testes da API
```bash
# Rodar todos os testes da API
robot src/API/tests/

# Rodar uma suíte específica (ex: Filmes)
robot src/API/tests/movies_test.robot

# Rodar apenas o teste de integração
robot src/API/tests/integration_test.robot

# Rodar por tags 
robot --include admin src/API/tests/
```

### Testes Web
```bash
# Rodar todos os testes Web
robot src/Web/tests/

# Rodar um teste específico (ex: Login)
robot src/Web/tests/login_test.robot

# Rodar por tags 
robot -t "" src/Web/tests/

# Rodar em modo Headless (sem abrir o navegador)
robot --variable headless:True src/Web/tests/

## Relatórios de Teste

Relatórios são gerados na raiz do projeto:
- `report.html` - Relatório de execução dos testes
- `log.html` - Log detalhado dos testes
- `output.xml` - Saída XML para CI/CD

## Configuração do Backend

Certifique-se de que a API do Cinema esteja rodando em `http://localhost:3000/api/v1`

## Configuração do Frontend

Certifique-se de que a aplicação Web do Cinema esteja rodando em `http://localhost:3002`