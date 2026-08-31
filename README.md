# win-cleaner 🧹

> 🖥️ **Plataforma:** Windows 10 & 11 | ⚙️ **Tecnologia:** Windows Batch (`.bat`) | ⚖️ **Licença:** MIT (Código Aberto)

Script automatizado projetado para realizar uma limpeza profunda no sistema, eliminação de caches redundantes e otimização de espaço em disco de forma rápida e segura.

---

## 🚀 Como Usar

1. **Baixe o arquivo** `win_cleaner.bat` deste repositório.
2. Clique com o **botão direito** sobre o arquivo baixado.
3. Selecione a opção **Executar como Administrador** 🛡️.
4. Aguarde a varredura automática e revise o relatório de espaço liberado.

---

## 📊 Fluxo de Execução

O script opera de forma totalmente silenciosa (ocultando logs desnecessários) e divide o processo em 5 etapas principais:

| Etapa | Alvo da Limpeza | O que é removido? |
| :---: | :--- | :--- |
| **1** | **Arquivos Temporários** | Conteúdo das pastas `%temp%`, `C:\Windows\Temp` e `C:\Temp`. |
| **2** | **Cache de Aplicativos** | Resíduos pesados do **Spotify** *(Data/Storage)* e do **Node.js** *(npm-cache)*. |
| **3** | **Rede & Otimização** | Flush completo de **DNS** e remoção de arquivos de **Prefetch** e `.log` antigos. |
| **4** | **Lixeira** | Esvaziamento forçado da lixeira de todos os discos rígidos conectados. |
| **5** | **Windows Update** | Limpeza de downloads antigos acumulados na pasta `SoftwareDistribution`. |

> 💡 **Nota sobre compatibilidade:** O script é inteligente. Se você não utiliza ferramentas como o Spotify ou Node.js, ele ignorará essas etapas silenciosamente, sem exibir alertas ou interromper o fluxo de limpeza.

---

## ✨ Diferenciais Visuais

* **Interface Dinâmica:** Exibe indicadores de progresso em tempo real (`[ WAIT ]` / `[  OK  ]`).
* **Suporte UTF-8 nativo:** Mensagens acentuadas corretamente direto no Prompt de Comando.
* **Cálculo de Armazenamento:** Integração com o PowerShell em segundo plano para calcular e exibir o total exato de megabytes (MB) ou gigabytes (GB) devolvidos ao seu disco **C:** ao final do processo.

---

## 🔒 Segurança & Privacidade

Este script utiliza apenas comandos administrativos nativos do Windows e variáveis de ambiente universais. Ele **não expõe** dados pessoais, caminhos locais estáticos, tokens ou chaves privadas, tornando seu uso seguro para execução local e compartilhamento público.
