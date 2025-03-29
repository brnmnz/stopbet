# 🛡️ ZeroBet

ZeroBet é um app focado em **ajudar pessoas a se protegerem de sites de apostas** e manterem o foco em suas metas. Através de monitoramento de tráfego e uma interface amigável, ele oferece um escudo digital contra distrações que afetam a saúde financeira e mental.

---

## ✨ Funcionalidades

✅ Tela de boas-vindas animada (splash screen)  
✅ Monitoramento de domínios via VPN (com suporte a Network Extension)  
✅ Bloqueio e log de acessos a sites como `blaze.com`, `bet365.com`, `pixbet.com`  
✅ Blog com dicas sobre como vencer o vício em apostas  
✅ Interface minimalista e responsiva com SwiftUI  
✅ Arquitetura limpa baseada em **MVVM + Services**

---

## 📸 Screenshots

| SplashScreen | Proteção | Blog |
|--------------|----------|------|
| ![splash](https://via.placeholder.com/200x400?text=Splash) | ![monitor](https://via.placeholder.com/200x400?text=Protecao) | ![blog](https://via.placeholder.com/200x400?text=Blog) |

---

## 🧠 Tecnologias

- `SwiftUI`
- `NetworkExtension`
- `Swift 5.9+`
- `MVVM` (Model–View–ViewModel)
- `UserNotifications`
- `URLSession` (para futuras chamadas de API)

---

## 🧱 Estrutura do Projeto

```plaintext
ZeroBet/
├── Views/             ← Telas do app (Home, Blog, Ativação)
├── ViewModels/        ← Lógicas das views (estado, chamadas)
├── Services/          ← Lógicas de sistema (VPN, notificações, DNS)
├── Models/            ← Estruturas de dados
├── Extensions/        ← Utils e helpers
└── DNSBlockerExtension/ ← Extensão VPN
```

##  🚀 Como rodar o projeto
Clone este repositório:

```
git clone https://github.com/seu-usuario/ZeroBet.git
cd ZeroBet
```

Abra o projeto no Xcode:

```
open ZeroBet.xcodeproj
```

Execute no seu iPhone (preferencialmente com conta Apple Developer paga, para testar VPN)

##  ⚠️ Observações
Para usar a Network Extension (VPN), é necessário:

- `Uma conta Apple Developer paga`
- `Ativar a Capability Network Extensions`
- `Assinar a extensão corretamente`

O app não coleta dados do usuário

O blog pode ser alimentado por API ou conteúdo local

##  👨‍💻 Autor
Desenvolvido por Bruno Hashimoto
