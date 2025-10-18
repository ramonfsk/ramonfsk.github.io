---
title: Como um Programador deve usar IA
date: 2025-10-18T19:19:32-03:00
slug: como-um-programador-deve-usar-ia
comments: true
tags:
- technology
- IA
- ios
- mobile
- software-engineer
---

## Introdução

A Inteligência Artificial se tornou uma ferramenta poderosa para desenvolvedores, mas é fundamental saber utilizá-la da forma correta. Este artigo demonstra um caso real de como usar IA para resolver problemas complexos de desenvolvimento iOS, especificamente a implementação de um gesto global em um super app.

## O Desafio

Imagine que você precisa implementar uma funcionalidade aparentemente simples: um gesto de arrastar da direita para a esquerda que abre uma nova tela. Mas há um problema: você trabalha em um super app com múltiplos módulos, e não existe um padrão de navegação definido. Alguns módulos usam deep links, outros usam coordinators para push de view controllers.

## Como a IA Pode Ajudar

### 1. **Forneça Contexto Completo**

Em vez de perguntar apenas "como fazer um swipe gesture?", explique o cenário completo:
- Qual é o objetivo da funcionalidade
- Quais são as restrições do projeto (super app, múltiplos módulos)
- Quais padrões já existem no código

### 2. **Itere e Refine a Solução**

A primeira solução nem sempre é a ideal. No nosso caso, começamos com uma abordagem básica e fomos refinando:

**Iteração 1:** Implementação básica do gesto
**Iteração 2:** Tornar o gesto global para toda a aplicação
**Iteração 3:** Garantir compatibilidade com diferentes arquiteturas (TabBar, NavigationController)
**Iteração 4:** Prevenir empilhamento de telas duplicadas
**Iteração 5:** Controle fino dos gestos com UIGestureRecognizerDelegate

## A Solução Final

### Entendendo a Hierarquia de Navegação no iOS

Antes de mergulhar no código, é fundamental entender como funciona a hierarquia de view controllers no iOS:

```
UIWindow (Janela raiz da aplicação)
    └── RootViewController (pode ser qualquer um dos seguintes:)
        
        ┌─ Caso 1: Navigation simples
        └── UINavigationController
              └── ViewController 1
                    └── ViewController 2 (push)
                          └── ViewController 3 (push)
        
        ┌─ Caso 2: TabBar
        └── UITabBarController
              ├── Tab 1: UINavigationController
              │     └── HomeViewController
              │           └── DetailViewController (push)
              ├── Tab 2: UINavigationController
              │     └── SearchViewController
              └── Tab 3: UINavigationController
                    └── ProfileViewController
        
        ┌─ Caso 3: SplitView (iPad)
        └── UISplitViewController
              ├── Master: UINavigationController
              │     └── MasterViewController
              └── Detail: UINavigationController
                    └── DetailViewController
```

**O desafio:** Nosso gesto precisa funcionar em TODAS essas estruturas!

### Por Que Usar UIWindow Extension?

O `UIWindow` é o nível mais alto da hierarquia visual do iOS. Tudo que você vê na tela está dentro de uma `UIWindow`. Ao adicionar o gesto no `UIWindow`, garantimos que ele funcione independente de:

- Qual view controller está sendo exibido
- Quantas telas foram empilhadas (pushed)
- Qual tab está ativa no TabBar
- Se há modais apresentados

**Vantagens:**
1. **Global por natureza:** Funciona em qualquer lugar do app
2. **Não invasivo:** Não precisa modificar cada view controller
3. **Fácil manutenção:** Um único ponto de controle
4. **Performance:** O gesto é registrado uma única vez

### Arquitetura da Solução

A solução final consiste em três componentes principais:

#### 1. **Extensão do UIWindow**

```swift
extension UIWindow {
  func addGlobalSwipeGesture(target: Any, action: Selector, delegate: UIGestureRecognizerDelegate? = nil) {
    let swipeGesture = UIScreenEdgePanGestureRecognizer(target: target, action: action)
    swipeGesture.edges = .right
    swipeGesture.delegate = delegate
    self.addGestureRecognizer(swipeGesture)
  }
}
```

**O que acontece aqui:**
- `UIScreenEdgePanGestureRecognizer`: Detecta arrastar da borda da tela
- `edges = .right`: Define que queremos detectar swipe da borda direita
- `delegate`: Permite controlar quando o gesto deve funcionar
- `addGestureRecognizer`: Adiciona o gesto na janela

**Por que isso funciona?**
Porque `UIWindow` é o contêiner de TUDO na aplicação. Qualquer toque na tela passa primeiro pela window, então o gesto é detectado independente do que está sendo exibido.

#### 2. **Navegação Inteligente - Encontrando o Navigation Controller Correto**

A solução inclui um método recursivo que encontra o navigation controller correto, independente da estrutura:

```swift
private func findNavigationController(from viewController: UIViewController?) -> UINavigationController? {
  guard let viewController = viewController else { return nil }
  
  // Verifica Navigation Controller direto
  if let navController = viewController as? UINavigationController {
    return navController
  }
  
  // Verifica TabBarController
  if let tabController = viewController as? UITabBarController {
    return findNavigationController(from: tabController.selectedViewController)
  }
  
  // Verifica SplitViewController (iPad)
  if let splitController = viewController as? UISplitViewController {
    // Tenta o detalhe primeiro
    if let detailNav = findNavigationController(from: splitController.viewControllers.last) {
      return detailNav
    }
    return findNavigationController(from: splitController.viewControllers.first)
  }
  
  // View Controller apresentado (modal)
  if let presentedVC = viewController.presentedViewController {
    return findNavigationController(from: presentedVC)
  }
  
  return viewController.navigationController
}
```

**Como funciona passo a passo:**

1. **Recebe um ViewController qualquer** (geralmente o `rootViewController` da window)

2. **Verifica se é NavigationController direto:**
   ```swift
   window.rootViewController → UINavigationController ✓
   ```
   Se for, retorna ele mesmo!

3. **Verifica se é TabBarController:**
   ```swift
   window.rootViewController → UITabBarController
       ├── selectedViewController → UINavigationController ✓
   ```
   Pega o tab selecionado atualmente e chama a função recursivamente

4. **Verifica se é SplitViewController:**
   ```swift
   window.rootViewController → UISplitViewController
       ├── viewControllers[0] (Master)
       └── viewControllers[1] (Detail) → UINavigationController ✓
   ```
   Prioriza o lado "Detail" (mais comum para push), se não encontrar tenta o "Master"

5. **Verifica se há modal apresentado:**
   ```swift
   viewController.presentedViewController → UINavigationController ✓
   ```
   Se o usuário abriu um modal, verifica se esse modal tem navigation

6. **Fallback final:**
   ```swift
   viewController.navigationController
   ```
   Se o próprio ViewController está dentro de um navigation, retorna ele

**Exemplo prático:**

Imagine esta estrutura:
```
UIWindow
  └── UITabBarController
        ├── Tab 1 (SELECIONADO) → UINavigationController
        │     └── HomeVC
        │           └── DetailVC (push atual)
        └── Tab 2 → UINavigationController
              └── SearchVC
```

**Fluxo de execução:**
```
1. findNavigationController(TabBarController)
2. É TabBar? SIM! → Pega selectedViewController (Tab 1)
3. findNavigationController(NavigationController do Tab 1)
4. É NavigationController? SIM! → RETORNA ✓
```

Agora sabemos que o Navigation correto é o do Tab 1, então podemos fazer push no `DetailVC`!

#### 3. **Controle com UIGestureRecognizerDelegate**

```swift
extension SceneDelegate: UIGestureRecognizerDelegate {
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                         shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
  
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    guard let navController = getCurrentNavigationController() else { return true }
    
    // Não ativa se já estiver na tela de feature
    if navController.topViewController is FeatureViewController {
      return false
    }
    
    return true
  }
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                         shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return false
  }
}
```

**Entendendo cada método do delegate:**

**1. `shouldRecognizeSimultaneouslyWith`:**
```swift
return true  // Permite que AMBOS gestos funcionem ao mesmo tempo
```
**Por quê?** O iOS tem um gesto nativo de "voltar" (swipe da ESQUERDA). Queremos que nosso gesto (swipe da DIREITA) funcione SEM conflitar com o gesto nativo. Retornando `true`, dizemos: "pode reconhecer os dois gestos juntos, sem problema!"

**2. `gestureRecognizerShouldBegin`:**
```swift
// Este método é chamado ANTES do gesto começar
// Podemos decidir: "deixa começar ou não?"

if navController.topViewController is FeatureViewController {
  return false  // NÃO deixa começar (já estamos na tela de Feature)
}
return true  // OK, pode começar!
```
**Por quê?** Prevenção de duplicação! Se já estamos na `FeatureViewController`, não faz sentido abrir ela de novo. Este método impede que o gesto seja reconhecido nesse caso.

**3. `shouldBeRequiredToFailBy`:**
```swift
return false  // Nosso gesto NÃO precisa falhar para outros funcionarem
```
**Por quê?** Por padrão, o iOS pode fazer um gesto "esperar" outro falhar antes de ativar. Retornando `false`, dizemos que nosso gesto pode ativar independentemente de outros gestos.

### Fluxo Completo de Execução

Vamos ver o que acontece quando o usuário faz o swipe:

```
👆 Usuário arrasta da borda direita
    ↓
❓ gestureRecognizerShouldBegin é chamado
    ↓
✓ Verifica: não estou na FeatureViewController? OK, pode começar!
    ↓
👌 Gesto é reconhecido
    ↓
🎯 handleGlobalSwipe é chamado
    ↓
🔍 getCurrentNavigationController() encontra o nav correto
    ↓
🔎 Verifica: FeatureViewController já existe na pilha?
    ↓
    ├─ SIM → Navega de volta para ela (popToViewController)
    └─ NÃO → Cria nova e faz push
```

## Boas Práticas ao Usar IA

### ✅ Faça

1. **Seja específico** sobre seu contexto e restrições
2. **Pergunte sobre edge cases** e compatibilidade
3. **Peça explicações** sobre o porquê de cada solução
4. **Teste e itere** com feedback real
5. **Solicite exemplos práticos** e código funcional

### ❌ Não Faça

1. **Copiar e colar sem entender** o código gerado
2. **Aceitar a primeira resposta** sem questionar
3. **Ignorar as particularidades** do seu projeto
4. **Esquecer de testar** em diferentes cenários
5. **Pular a documentação oficial** da Apple

## Demonstração em Vídeo

![Demo do Gesto Global](https://i.imgur.com/eHbdb9W.mp4)

*Vídeo mostrando o gesto funcionando em diferentes tabs e telas aninhadas*

## Resultados

A solução final:

- ✅ Funciona em qualquer estrutura de navegação (TabBar, Navigation, SplitView)
- ✅ Não empilha telas duplicadas
- ✅ Respeita os gestos nativos do iOS
- ✅ É facilmente testável e manutível
- ✅ Segue as diretrizes da Apple

## Conclusão

Usar IA no desenvolvimento não significa apenas gerar código rapidamente. Significa ter um assistente que ajuda você a:

- **Explorar diferentes abordagens** para o mesmo problema
- **Entender as implicações** de cada decisão de arquitetura
- **Aprender boas práticas** enquanto desenvolve
- **Economizar tempo** em pesquisas e documentação

A chave está em fazer as perguntas certas, fornecer contexto adequado e ter senso crítico sobre as soluções propostas. A IA é uma ferramenta poderosa, mas o desenvolvedor ainda é quem toma as decisões finais baseado no conhecimento do projeto e dos requisitos do negócio.

## Dica Final

Sempre que usar IA para desenvolvimento:

1. Comece com o problema, não com a solução
2. Forneça contexto completo
3. Questione e refine as respostas
4. Teste em cenários reais
5. Documente o que aprendeu

Dessa forma, você não apenas resolve o problema imediato, mas também evolui como desenvolvedor e constrói soluções mais robustas e escaláveis.