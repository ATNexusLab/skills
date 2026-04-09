---
name: mobile-patterns
description: Use quando precisar implementar features mobile (React Native, Flutter, Swift, Kotlin), configurar builds, resolver problemas de plataforma ou adaptar UI para mobile.
type: skill
targets: [copilot-cli, gemini-cli, antigravity]
---

# Mobile Patterns

> ⚠️ EXPERIMENTAL — Ainda não validado em produção.

## Quando Usar

- Implementar features em React Native, Flutter, Swift ou Kotlin
- Configurar builds para iOS e Android
- Resolver problemas específicos de plataforma
- Adaptar componentes web para comportamento mobile

## Padrões Fundamentais

### Performance Mobile

- Evitar re-renders em listas longas: usar `FlatList` (RN) ou `ListView.builder` (Flutter) — nunca renderizar tudo de uma vez
- Imagens: usar CDN, tamanhos otimizados, lazy loading
- Animações: rodar na thread nativa, não na JS thread (React Native: `useNativeDriver: true`)
- Evitar operações síncronas pesadas na main thread

### Navegação

- Separar navegação de lógica de negócio
- Gerenciar deep links com atenção a segurança (validar parâmetros)
- Preservar estado de scroll e posição ao voltar de screens

### Offline e Conectividade

- Detectar estado de rede antes de operações críticas
- Implementar retry com backoff para chamadas de API
- Cache local para dados frequentemente acessados
- Sincronização de dados offline com conflito handling

### Segurança Mobile

- Nunca armazenar secrets ou tokens no código
- Usar Keychain (iOS) ou Keystore (Android) para dados sensíveis
- Certificate pinning para APIs críticas
- Ofuscação de código em builds de produção

### Build e Deploy

```bash
# React Native — build Android
cd android && ./gradlew assembleRelease

# React Native — build iOS
xcodebuild -workspace ios/App.xcworkspace -scheme App -configuration Release

# Flutter — build
flutter build apk --release
flutter build ios --release
```

## Checklist Pré-Release

- [ ] Testado em dispositivo real (não só emulador)
- [ ] Testado nos tamanhos de tela principais
- [ ] Permissões solicitadas com justificativa clara
- [ ] Deep links testados
- [ ] Performance em dispositivos de baixo desempenho
- [ ] Sem dados sensíveis em logs de produção
- [ ] Build assinado com certificado correto
