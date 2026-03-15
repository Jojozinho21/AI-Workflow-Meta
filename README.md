<img width="100%" src="https://capsule-render.vercel.app/api?type=waving&color=0:6C5CE7,50:0984e3,100:00CEC9&height=120&section=header&text=&fontSize=0" />

<div align="center">

# ⚡ AI Workflow Meta

### Crie nucleos de AI completos com IA — direto no terminal.

<br>

[![Claude Code](https://img.shields.io/badge/Claude_Code-Skills-blueviolet?style=for-the-badge)](https://claude.ai)
[![Markdown](https://img.shields.io/badge/Markdown-Templates-000000?style=for-the-badge&logo=markdown&logoColor=white)](https://daringfireball.net/projects/markdown/)
[![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](LICENSE)

[Instalacao](#instalacao) · [Como Usar](#como-usar) · [Brains](#os-8-brains) · [Templates](#6-templates-parametrizados) · [Ecossistema](#ecossistema)

</div>

<br>

## O que e isso?

Um sistema de **8 skills** para o [Claude Code](https://docs.anthropic.com/en/docs/claude-code) que transforma o terminal em uma fabrica de nucleos de AI.

Tres comandos. Oito brains especializados. Pipeline automatico.

| Comando | O que faz |
|:--------|:----------|
| `/workflow-criar` | Cria um nucleo **do zero** com brains, routing, pipelines, memoria |
| `/workflow-editar` | Edita nucleos **existentes** — adiciona brains, ajusta routing, modifica skills |
| `/workflow-analisar` | Analisa nucleo — 17 checks de qualidade, arquitetura, routing, memoria |

<br>

## Instalacao

```bash
# 1. Clone
git clone https://github.com/Jojozinho21/AI-Workflow-Meta.git

# 2. Instale
cd AI-Workflow-Meta && ./install.sh

# 3. Reinicie o Claude Code. Pronto.
```

<details>
<summary><b>Instalacao manual</b></summary>

```bash
git clone https://github.com/Jojozinho21/AI-Workflow-Meta.git
cp -r AI-Workflow-Meta/.claude/skills/* ~/.claude/skills/
```

</details>

<br>

## Como usar

### ⚒️ `/workflow-criar` — Criar do zero

```
> /workflow-criar

Cria um nucleo para gerenciar bots de Telegram
com comandos, intents, deploy e monitoramento.
```

O que acontece:

```
📐 FASE 1 — Projetar     → Analisa dominio, gera Nucleo Spec com brains e routing
⏸️  GATE                  → Spec aprovada pelo usuario
🔨 FASE 2 — Gerar        → Transforma spec em arquivos via 6 templates parametrizados
✅ FASE 3 — Validar      → Audita contra 17 criterios de qualidade
🔄 FASE 4 — Fix Loop     → Se falhar, corrige e revalida (max 2 iteracoes)
```

---

### ✏️ `/workflow-editar` — Editar existente

```
> /workflow-editar

Adiciona brain de integracao ao nucleo de Telegram.
O nucleo esta em ~/Desktop/Nucleo Telegram/
```

O que acontece:

```
🔍 FASE 1 — Mapear       → Le o nucleo, entende arquitetura e brains
🛡️ FASE 2 — Proteger      → Identifica blast radius, preserva o que funciona
✏️ FASE 3 — Editar        → Mudanca minima, segue convencoes do nucleo original
✅ FASE 4 — Validar       → Audita 17 criterios no nucleo editado
```

---

### 🔬 `/workflow-analisar` — Analisar / Auditar

```
> /workflow-analisar

Analisa o nucleo em ~/Desktop/Nucleo Discord/
O brain-dev nunca ativa.
```

O que acontece:

```
📊 INVENTARIO              → Lista brains, routing, pipelines, memoria
🔍 VALIDACAO 17 CHECKS     → Audita contra 17 criterios de qualidade
🏗️ ARQUITETURA             → Coerencia de routing, pipelines, gates
🧠 MEMORIA                 → Schema, consistencia, uso correto
📋 RELATORIO               → Findings com severidade (CRITICAL/WARNING/INFO)
```

<br>

## Os 8 Brains

| Brain | Ativa quando | O que faz |
|:------|:-------------|:----------|
| `workflow-criar` | **Criar nucleo** | **Roteador: ativa pipeline architect → generator → validator** |
| `workflow-editar` | **Editar nucleo** | **Mapeia, protege e edita nucleo existente** |
| `workflow-analisar` | **Analisar nucleo** | **Audita e entrega relatorio com findings** |
| `workflow-architect` | Projetar spec | Analisa dominio e gera Nucleo Spec aprovada |
| `workflow-generator` | Spec aprovada | Gera todos os arquivos via templates parametrizados |
| `workflow-validator` | Nucleo gerado | Audita 17 criterios de qualidade, aprova ou devolve |
| `workflow-retrospective` | Analisar nucleos passados | Propoe melhorias em templates com base em evidencia |
| `workflow-prompt` | Mudar estrutura do sistema | Meta-otimiza o proprio Nucleo Workflow |

Cada brain segue a **anatomia padrao de 7 secoes**:

```
Papel → Pre-condicoes → Regras → Templates → Checklist → Post-condicoes → Handoff
```

<br>

## Pipelines Automaticos

```
Criar Nucleo       architect → generator → validator → [fix if issues] → DONE
Melhorar Templates retrospective → [proposals] → aprovacao → aplicar → DONE
Meta-Otimizacao    workflow-prompt → [proposals] → aprovacao → aplicar → DONE
```

Cada brain tem **gates de entrada e saida**. O pipeline so avanca quando as pos-condicoes sao cumpridas.

<br>

## 6 Templates Parametrizados

Templates com `{{PLACEHOLDER}}` que geram todos os arquivos de um nucleo:

| Template | Gera | Parametros |
|:---------|:-----|:-----------|
| `claude-md.tmpl.md` | CLAUDE.md (dispatcher) | 9 — regras, routing, playbooks |
| `brain-skill.tmpl.md` | Brain skills completas | 10 — 7 secoes da anatomia |
| `context.tmpl.md` | .ai/CONTEXT.md | 6 — stack, tools, convencoes |
| `memory-knowledge.tmpl.md` | Memoria persistente | Schema fixo com 5 secoes |
| `memory-sessions.tmpl.md` | Log de sessoes | Max 5 bullets, 10 detalhadas |
| `playbooks.tmpl.md` | Pipelines do nucleo | Sequencia de brains com gates |

<br>

## 17 Verificacoes de Qualidade

O Validator aplica **17 checks** em todo nucleo gerado:

```
✅ CLAUDE.md < 100 linhas          ✅ Checklist de self-review
✅ Skills < 400 linhas             ✅ Routing cobre todos brains
✅ Frontmatter valido              ✅ Playbooks referenciam brains validos
✅ 3+ trigger phrases por skill    ✅ Memoria com schema rigido
✅ Zero duplicacao de regras       ✅ Nenhum placeholder/TODO
✅ Pre-condicoes em cada brain     ✅ Toda regra com justificativa (WHY)
✅ Post-condicoes em cada brain    ✅ Handoff explicito entre brains
✅ Gates de entrada definidos      ✅ Pipelines com terminacao garantida
✅ install.sh funcional
```

<br>

## 7 Regras Imutaveis

Estas regras **nunca** sao quebradas, por nenhum brain:

| # | Regra |
|:--|:------|
| 1 | Nunca gerar nucleo sem spec aprovada |
| 2 | Sempre anatomia de 7 secoes em cada brain skill |
| 3 | CLAUDE.md gerado deve ter < 100 linhas |
| 4 | Cada skill gerada deve ter < 400 linhas |
| 5 | Nunca duplicar regras entre Camada 1 e Camada 2 |
| 6 | Toda regra gerada deve incluir justificativa (WHY) |
| 7 | Templates so mudam via retrospectiva ou workflow-prompt aprovados |

<br>

## Memoria entre Sessoes

O sistema **lembra** decisoes e contexto entre sessoes:

```
.ai/
├── MEMORY_KNOWLEDGE.md    ← Decisoes, entidades, padroes, anti-padroes
├── MEMORY_SESSIONS.md     ← Log comprimido (ultimas 10 sessoes)
└── CONTEXT.md             ← Stack, convencoes, integracoes
```

- Decisoes criticas salvas **imediatamente**
- Conflitos com memoria existente → **flag ao usuario**
- Compactacao automatica quando excede limite

<br>

## Estrutura

```
.
├── CLAUDE.md                          # Dispatcher (sempre carregado)
├── install.sh                         # Instalador one-click
├── .claude/skills/                    # 8 brains
│   ├── workflow-criar/SKILL.md        #   /workflow-criar (roteador)
│   ├── workflow-editar/SKILL.md       #   /workflow-editar (editor)
│   ├── workflow-analisar/SKILL.md     #   /workflow-analisar (auditor)
│   ├── workflow-architect/SKILL.md    #   Projeta nucleos
│   ├── workflow-generator/SKILL.md    #   Gera arquivos
│   ├── workflow-validator/SKILL.md    #   Valida qualidade (17 checks)
│   ├── workflow-retrospective/SKILL.md #  Melhora templates
│   └── workflow-prompt/SKILL.md       #   Meta-otimizacao
├── templates/                         # 6 templates parametrizados
│   ├── claude-md.tmpl.md
│   ├── brain-skill.tmpl.md
│   ├── context.tmpl.md
│   ├── memory-knowledge.tmpl.md
│   ├── memory-sessions.tmpl.md
│   └── playbooks.tmpl.md
├── .ai/                               # Contexto e memoria
│   ├── CONTEXT.md
│   ├── MEMORY_KNOWLEDGE.md
│   └── MEMORY_SESSIONS.md
├── nucleos/
│   └── registry.md                    # Registro de nucleos gerados
└── docs/                              # Specs e planos
```

<br>

## Ecossistema

Parte da familia **AI-Workflow** por [</zJoo>](https://github.com/Jojozinho21):

| Workflow | Dominio | Descricao | Skills |
|:---------|:--------|:----------|:-------|
| [**AI-Workflow-Meta**](https://github.com/Jojozinho21/AI-Workflow-Meta) | Meta-workflow (este repo) | Cria, edita e analisa nucleos de AI completos | 8 brains |
| [**AI-Workflow-Discord**](https://github.com/Jojozinho21/AI-Workflow-Discord) | Bots Discord (TypeScript) | Pipeline completo: architect → dev → testing → ops | 8 brains |
| [**AI-Workflow-SobbleMC**](https://github.com/Jojozinho21/AI-Workflow-SobbleMC) | Plugins Minecraft (Java) | Cria, edita e analisa plugins Spigot/Paper | 3 skills |
| [**AI-Workflow-Github**](https://github.com/Jojozinho21/AI-Workflow-Github) | GitHub | Commits, READMEs, perfis, releases, setup | 6 brains |

<br>

## Dicas

> **Seja especifico no dominio.**
> "Bot de Telegram com comandos, webhook e deploy Docker" e melhor que "bot de telegram".

> **Mencione a stack alvo.**
> O Architect adapta o nucleo para a stack que voce informar.

> **Peca retrospectiva apos 3+ nucleos.**
> O sistema analisa padroes e propoe melhorias nos templates com base em evidencia.

<br>

## Licenca

MIT — use, modifique e distribua livremente.

<div align="center">

<br>

Feito por **</zJoo>** · [SobbleMC](https://github.com/Jojozinho21)

*Powered by [Claude Code](https://claude.ai/claude-code)*

</div>

<img width="100%" src="https://capsule-render.vercel.app/api?type=waving&color=0:00CEC9,50:0984e3,100:6C5CE7&height=80&section=footer" />
