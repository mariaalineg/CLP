# 🛠️ Projeto OpenPLC: Leitura de Potenciômetro com Arduino Nano

## 🎯 Objetivo

Ler o valor de um potenciômetro conectado à entrada analógica A0 de um **Arduino Nano** usando o **OpenPLC**, e acender um LED quando o valor lido for maior que `32767`.

---

## 🧰 Materiais

- 1× Arduino Nano
- 1× Potenciômetro (ex: 10kΩ)
- 1× Protoboard (opcional)
- Cabos jumper
- 1× LED (opcional — o Nano já possui um LED interno no pino D13)
- Computador com OpenPLC Editor e Runtime instalados

---

## ⚡ Montagem do Circuito

Conecte o potenciômetro conforme o esquema:

| Pino do Potenciômetro | Conexão no Arduino Nano |
|------------------------|--------------------------|
| Terminal esquerdo      | GND                      |
| Terminal central       | A0                       |
| Terminal direito       | 5V                       |

> 💡 **Dica:** O Arduino Nano possui um LED interno no pino D13, que pode ser usado como saída visual sem necessidade de componentes adicionais.

**Imagem do protótipo montado**
![montagem](https://github.com/user-attachments/assets/619128c6-8dcf-4257-ae9c-f270ff3c3f66)
---

## 💻 Configuração no OpenPLC

### 1. Configuração de Variáveis Globais

- Abra o **OpenPLC Editor**
- Vá em **Project → Global Variables**

Adicione as seguintes variáveis:

| Nome        | Tipo  | Localização | Descrição                    |
|-------------|-------|-------------|------------------------------|
| pot_valor   | UINT  | %IW0        | Leitura do potenciômetro (A0)|
| led_saida   | BOOL  | %QX0.0      | Saída para o LED (D13)       |
| ref         | UINT  |             | valor de referência          |

**Tela do OpenPLC configurada:**

![Configuração de variáveis](https://github.com/user-attachments/assets/ac0da778-db17-42f2-b9bb-c68a058ce3ab)

---

### 2. Programa Ladder

**Lógica:**  
Se o valor lido do potenciômetro (`pot_valor`) for maior que 32767, ativa-se a saída `led_saida`.

**Implementação:**
1. Adicione um bloco comparador **GT** (Greater Than)
2. Conecte `pot_valor` à entrada **IN1**
3. Conecte `ref` à entrada **IN2** (também pode ser usada uma constante com o valor **32767**)
4. Conecte a saída **OUT** do bloco a uma bobina (coil) ligada a `led_saida`

> 💡 **Vantagem de usar a variável `ref`:** Permite alterar o valor de referência dinamicamente pelo OpenPLC Runtime sem necessidade de recompilar o programa.

![Diagrama Ladder](https://github.com/user-attachments/assets/20e10173-a03b-4d13-b5de-68b9843c1784)

---

## ⚙️ Upload e Execução no Arduino Nano

1. **Compile** o programa no OpenPLC Editor
2. Acesse o **OpenPLC Runtime** pelo navegador (geralmente em `http://localhost:8080`)
3. Faça login (usuário padrão: `openplc` / senha: `openplc`)
4. Vá em **Programs** e faça upload do arquivo `.st` compilado
5. Em **Hardware**, selecione **Arduino Nano** como plataforma
6. Clique em **Start PLC** para iniciar a execução

---

## 🧪 Teste do Sistema

Gire o potenciômetro e observe o comportamento do LED:

- **Valor < 32767** (≈ tensão < 2,5V): LED apagado
- **Valor ≥ 32767** (≈ tensão ≥ 2,5V): LED aceso

![Demonstração em vídeo](https://github.com/user-attachments/assets/3466a345-6b2b-40ab-984e-4db002985985)

> **Monitore os valores em tempo real** através da interface do OpenPLC Runtime para visualizar a leitura do potenciômetro.

---

## 🧠 Dicas e Expansões

- O valor de `%IW0` varia entre **0 e 65535**, proporcional à tensão de entrada (0–5V)
- Modifique o valor de comparação (32767) para testar diferentes limites de acionamento
- **Ideias de expansão:**
  - Implementar controle PWM
  - Adicionar controle de motores DC ou servomotores
  - Criar sistema de alarme com múltiplos sensores
  - Implementar lógica de histerese para evitar oscilações

---

## 🔗 Referências

- [OpenPLC - Site Oficial](https://www.autonomylogic.com/)
- [Wiki do OpenPLC](https://github.com/thiagoralves/OpenPLC_v3/wiki)
- [Fórum da Comunidade](https://openplc.discussion.community/)
