# Weather Application 🌤️

Uma aplicação desenvolvida em **Swift** com **UIKit** que exibe informações sobre o clima em tempo real para diferentes localidades.

## 🚀 Funcionalidades

- Exibição de informações meteorológicas detalhadas, incluindo:
  - Temperatura atual.
  - Condição do tempo (ensolarado, nublado, chuvoso, etc.).
  - Velocidade do vento e umidade.
- Interface responsiva e intuitiva para fácil navegação.

## 🛠️ Tecnologias Utilizadas

- **Swift**: Linguagem principal de programação.
- **UIKit**: Framework para construção da interface nativa.
- **OpenWeather API**: Para obtenção de informações sobre o clima em tempo real.

## 📱 Pré-requisitos

- Xcode instalado.
- Dispositivo ou simulador com iOS 15 ou superior.
- Uma chave de API válida do [OpenWeather](https://openweathermap.org/api).

## 📦 Como Executar o Projeto

### Passo a Passo

1. Clone este repositório:
   ```bash
   git clone https://github.com/chrystiansantos/weather.git
   cd weather
   ```

2. Abra o arquivo do projeto no Xcode:
   - Clique duas vezes no arquivo `Weather.xcodeproj`.

3. Configure a chave de API:
   - No arquivo `Service.swift`, substitua o valor da variável `apiKey` pela sua chave de API:
     ```swift
     private let apiKey: String = "YOUR_API_TOKEN"
     ```

4. Execute o projeto:
   - No Xcode, selecione um simulador ou dispositivo real e clique no botão de **Run** (⏵).

Criado com ❤️ por [Chrystian Santos](https://github.com/chrystiansantos).

<img width="1506" alt="weather-app" src="https://github.com/user-attachments/assets/99924662-d044-497e-bd18-038f4681e57f" />
