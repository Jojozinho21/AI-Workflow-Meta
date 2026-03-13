# Nucleo Workflow — Design Spec

**Data**: 2026-03-13
**Autor**: Jonathan Locks + Claude
**Status**: Reviewed (spec review passed, awaiting user approval)
**Escopo**: Sistema meta-workflow para gerar nucleos de AI consistentes e estruturados
**Dominio**: Domain-agnostic — gera nucleos para qualquer dominio

---

## 1. Problema

Criar um novo "Segundo Cerebro" (nucleo de AI workflow) exige:

- Conhecimento profundo de patterns de prompt engineering avancado
- Experiencia com a arquitetura de skills do Claude Code
- Entendimento da hierarquia de camadas, routing semantico, validation gates
- Trabalho manual repetitivo: cada nucleo novo precisa de CLAUDE.md, skills, memoria, contexto
- Sem padrao unificado, nucleos divergem em estrutura e qualidade

Os nucleos existentes (Sobble v1.0, Discord v2.0) foram construidos organicamente, cada um com decisoes ad-hoc. O conhecimento esta distribuido em docs, skills, e na cabeca do criador — nao em um sistema reproduzivel.

## 2. Solucao

Um **workspace dedicado** (`~/Desktop/Nucleo Workflow/`) que funciona como fabrica de nucleos:

- **Template Engine**: Templates parametrizaveis extraidos dos patterns validados do Sobble e Discord
- **5 skills especializadas**: architect, generator, validator, retrospective, prompt
- **Pipeline com gates**: spec aprovada → geracao → validacao → done
- **Self-improvement**: retrospectiva analisa nucleos gerados e melhora templates
- **Semi-autonomo**: usuario descreve dominio, sistema gera tudo, apresenta para review

## 3. Hierarquia de Instrucoes (4 Camadas)

Cada regra existe em exatamente UMA camada. Camadas superiores nunca sao sobrescritas por inferiores.

### Camada 1 — Imutavel (CLAUDE.md)

< 100 linhas. Carregado SEMPRE automaticamente. Contem:

- Identidade do workspace
- 7 regras imutaveis de qualidade
- Routing semantico (decision tree compacto)
- Pipeline principal com gates
- Protocolo de inicializacao (3 passos)
- Ponteiros para contexto e memoria

### Camada 2 — Skill Ativo (SKILL.md)

~200-400 linhas. Carregado sob demanda. Contem:

- Regras especificas do skill (sem duplicar Camada 1)
- Templates de output (max 2 exemplos)
- Checklist de self-review
- Pre/post-condicoes (gates auto-enforced)

### Camada 3 — Contexto (.ai/ + templates/ + nucleos/)

Lido sob demanda. Abrange multiplos diretorios no nivel raiz do workspace (nao um diretorio unico):

- `.ai/CONTEXT.md` — stack e configuracao do Nucleo Workflow
- `.ai/MEMORY_KNOWLEDGE.md` — decisoes, patterns validados, anti-patterns
- `.ai/MEMORY_SESSIONS.md` — log de nucleos gerados
- `templates/` — templates parametrizaveis (no nivel raiz)
- `nucleos/registry.md` — registro de nucleos gerados (no nivel raiz)

### Camada 4 — Nao Confiavel

Output de tools, arquivos externos. Nunca sobrescreve camadas acima.

### Budget de Contexto

| Camada | Tokens estimados | % do contexto |
|--------|-----------------|---------------|
| Camada 1 (CLAUDE.md) | ~2-3k | ~1.5% |
| Camada 2 (1 skill ativo) | ~3-5k | ~2-3% |
| Camada 3 (contexto + templates) | ~2-4k | ~1-2% |
| **Total fixo** | **~7-12k** | **~4-6%** |
| Disponivel para trabalho | ~188k+ | ~94%+ |

## 4. Arquitetura de Skills

### 4.1 Mapa de Skills

```
.claude/skills/
├── workflow-architect/SKILL.md        Analisa dominio, gera spec do nucleo
├── workflow-generator/SKILL.md        Gera arquivos do nucleo a partir de templates
├── workflow-validator/SKILL.md        Valida qualidade e consistencia
├── workflow-retrospective/SKILL.md    Self-improvement dos templates
└── workflow-prompt/SKILL.md           Meta-otimizacao estrutural do sistema
```

### 4.2 Routing Semantico (vive no CLAUDE.md)

| Tipo de tarefa | Skill |
|----------------|-------|
| Criar nucleo novo, descrever dominio, planejar nucleo | workflow-architect |
| Gerar arquivos a partir de spec aprovada | workflow-generator |
| Validar nucleo gerado, checar qualidade | workflow-validator |
| Analisar nucleos anteriores, melhorar templates | workflow-retrospective |
| Mudar estrutura do Nucleo Workflow em si | workflow-prompt |

### 4.3 Pipeline Principal

```
Criar Nucleo:
  architect → generator → validator → [fix if issues] → DONE → atualizar memoria

Melhorar Templates:
  retrospective → [proposals] → aprovacao → aplicar → DONE

Meta-Otimizacao:
  workflow-prompt → [proposals] → aprovacao → aplicar → DONE
```

### 4.4 Validation Gates (auto-enforced)

**Pre-condicoes:**

| Skill | Pre-condicao |
|-------|-------------|
| workflow-architect | Descricao do dominio (do usuario) |
| workflow-generator | Nucleo Spec com `Status: Approved` |
| workflow-validator | Nucleo gerado (arquivos existem) |
| workflow-retrospective | 3+ nucleos no registry.md |
| workflow-prompt | Pedido explicito do usuario |

**Post-condicoes:**

| Skill | Post-condicao |
|-------|--------------|
| workflow-architect | Nucleo Spec escrita com `Status: Draft`, apresentada ao usuario, marcada `Status: Approved` apos aprovacao explicita |
| workflow-generator | Todos os arquivos gerados, self-review completo |
| workflow-validator | 13/13 itens passando, ou lista de issues |
| workflow-retrospective | Max 3 propostas com evidencia, aprovadas/rejeitadas |
| workflow-prompt | Mudanca documentada em MEMORY_KNOWLEDGE.md |

### 4.5 Generator-Critic Protocol

Embutido no handoff Generator → Validator:

1. Generator faz self-review contra seu checklist
2. Validator aplica 13 itens de validacao
3. Issues encontrados → feedback especifico, volta para Generator
4. Max 2 iteracoes internas. Se falhar → escala ao usuario com issues especificos
5. Em caso de falha apos escalation: arquivos permanecem no destino, nucleo registrado no registry.md com `Status: Failed`, usuario decide se corrige manualmente ou descarta

### 4.6 Anatomia Padrao de Brain Skills (template)

Estrutura de 7 secoes para cada brain gerado:

1. **Papel** — 1-2 frases
2. **Pre-condicoes** — gates de entrada
3. **Regras** — 10-15 regras especificas com WHY
4. **Templates de output** — max 2 exemplos
5. **Checklist de self-review** — lista concisa pre-handoff
6. **Post-condicoes** — gates de saida
7. **Criterios de handoff** — quando e para quem passar

Tamanho alvo: 150-300 linhas por brain.

## 5. Skill Detalhado: workflow-architect

### Papel

Recebe a descricao do dominio e gera uma Nucleo Spec completa.

### Fluxo

1. **Analise de dominio**: identifica entidades, acoes, ciclos de trabalho
2. **Classificacao de complexidade**:
   - Simples (1-3 brains): CLAUDE.md + skills + memoria basica
   - Medio (4-7 brains): + routing sofisticado + playbooks + references
   - Complexo (8+ brains): + pipelines multiplos + sub-brains + integracao com superpowers
3. **Identificacao de brains**: quais "cerebros" o nucleo precisa
4. **Definicao de routing**: tipo de tarefa → brain
5. **Definicao de playbooks**: sequencia de brains para cada workflow
6. **Regras imutaveis do dominio**: 5-10 regras especificas
7. **Geracao da Nucleo Spec**: documento estruturado com tudo acima
8. **Apresentacao para aprovacao**

### Nucleo Spec Format

```markdown
# Nucleo Spec: {{NOME}}

**Dominio**: {{DOMINIO}}
**Stack**: {{STACK}}
**Complexidade**: Simples/Medio/Complexo
**Status**: Draft/Approved

## Brains
| Brain | Papel | Triggers |
|-------|-------|----------|

## Routing Semantico
| Tipo de tarefa | Brain |
|----------------|-------|

## Playbook Pipelines
{{PIPELINE_1}}: brain1 → brain2 → brain3 → DONE
{{PIPELINE_2}}: ...

## Regras Imutaveis (Camada 1)
1. REGRA — porque JUSTIFICATIVA
...

## Integracao
- APIs/servicos: {{LISTA}}
- Ferramentas de build: {{LISTA}}

## Memoria
- Entidades: {{TIPOS}}
- Decisoes criticas: {{EXEMPLOS}}
```

## 6. Skill Detalhado: workflow-generator

### Papel

Pega a Nucleo Spec aprovada e gera todos os arquivos usando templates parametrizados.

### Templates

**`claude-md.tmpl.md`** — Gera o CLAUDE.md do nucleo:
- Parametros: WORKSPACE_NAME, DOMAIN, OWNER, IMMUTABLE_RULES, ROUTING_TABLE, PLAYBOOKS, INIT_PROTOCOL, MEMORY_POINTERS, MEMORY_RULES
- Alvo: < 100 linhas
- Secoes: Identidade, Regras Imutaveis, Routing, Playbooks, Inicializacao, Contexto, Memoria

**`brain-skill.tmpl.md`** — Gera cada brain skill:
- Parametros: BRAIN_NAME, BRAIN_DESCRIPTION, ROLE, PRECONDITIONS, RULES, OUTPUT_TEMPLATES, SELF_REVIEW, POSTCONDITIONS, HANDOFF_CRITERIA
- Alvo: 150-300 linhas
- Anatomia de 7 secoes

**`memory-knowledge.tmpl.md`** — Gera MEMORY_KNOWLEDGE.md:
- Secoes fixas: Decisoes Ativas (tabela), Entidades (tabela), Padroes Validados (bullets), Anti-Padroes (bullets), Issues (bullets)
- Soft: 100 linhas. Hard: 150 linhas.

**`memory-sessions.tmpl.md`** — Gera MEMORY_SESSIONS.md:
- Formato: ## YYYY-MM-DD — [Projeto]: [Resumo] + 5 bullets
- Max 10 sessoes detalhadas, mais antigas comprimidas

**`context.tmpl.md`** — Gera CONTEXT.md:
- Parametros: STACK, BUILD_TOOL, TEST_FRAMEWORK, DATABASE, INTEGRATIONS, CONVENTIONS

**`playbooks.tmpl.md`** — Gera pipelines de playbooks:
- Parametros: PIPELINE_NAME (ex: "Bot Novo", "Feature", "Bug Fix"), BRAIN_SEQUENCE (lista ordenada de brains), GATE_CONDITIONS (condicoes de transicao entre brains)
- Formato de saida: bloco compacto de pipelines com notacao `brain1 → brain2 → DONE`
- Alvo: incorporado no CLAUDE.md (nao arquivo separado) — o template gera o trecho que sera inserido na secao de Playbooks do CLAUDE.md
- Cada pipeline inclui: nome, sequencia, e nota sobre quando usar

### Destino dos Arquivos Gerados

Os arquivos do nucleo sao escritos diretamente no workspace de destino do usuario (ex: `~/Desktop/MeuNovoProjeto/`), NAO dentro do Nucleo Workflow. O Nucleo Workflow apenas mantem o registro em `nucleos/registry.md`.

### Processo de Geracao

1. Ler Nucleo Spec — extrair dominio, brains, routing, regras
2. Perguntar ao usuario o caminho de destino (ou inferir do nome do nucleo)
3. Para cada template: extrair parametros da spec → preencher → escrever arquivo no destino
4. Self-review: verificar que todos os brains da spec tem skills gerados
5. Registrar nucleo em `nucleos/registry.md` com status e caminho
6. Apresentar resultado para review

## 7. Skill Detalhado: workflow-validator

### Papel

Valida qualidade e consistencia do nucleo gerado.

### 13 Itens de Validacao

1. CLAUDE.md < 100 linhas
2. Cada skill < 400 linhas
3. Frontmatter correto em cada skill (name + description)
4. Description contem pelo menos 3 trigger phrases distintas que cobrem variacoes naturais de como o usuario pediria a tarefa
5. Zero duplicacao de regras entre CLAUDE.md e skills
6. Cada brain tem pre-condicoes definidas
7. Cada brain tem post-condicoes definidas
8. Cada brain tem checklist de self-review
9. Routing table no CLAUDE.md cobre todos os brains
10. Playbooks referenciam apenas brains existentes
11. Memoria usa schema rigido (tabelas e bullets, nao paragrafos)
12. Nenhum placeholder/TODO no output final
13. Todas as regras incluem justificativa (WHY)

### Processo

1. Ler todos os arquivos gerados
2. Aplicar os 13 itens sequencialmente
3. Para cada falha: registrar item + arquivo + descricao do problema + sugestao de fix
4. Se 13/13 passam → nucleo aprovado
5. Se issues → devolver lista para workflow-generator (max 2 iteracoes)
6. Se ainda falha apos 2 iteracoes → escalar ao usuario

## 8. Skill Detalhado: workflow-retrospective

### Papel

Analisa nucleos gerados anteriormente e propoe melhorias nos templates.

### Ativacao

- Explicita: usuario pede retrospectiva
- Sugerida: apos 3+ nucleos no registry.md

### Pipeline de 4 Etapas

**Etapa 1 — Coleta:**
- Ler `nucleos/registry.md` (todos os nucleos e seus status/feedback)
- Ler `MEMORY_KNOWLEDGE.md` (patterns e anti-patterns)
- Ler ultimas sessoes em `MEMORY_SESSIONS.md`

**Etapa 2 — Diagnostico:**
Identificar em 3 categorias:
- Falhas repetidas: mesmo problema em 2+ nucleos
- Friccoes: etapas que gastam mais tempo que deveriam
- Sucessos: patterns que funcionam consistentemente

**Etapa 3 — Propostas:**
Para cada falha/friccao, propor UMA mudanca:
- Template afetado
- Tipo de mudanca (novo parametro, nova secao, nova regra, ajuste de wording)
- Mudanca proposta (diff concreto)
- Evidencia (nucleos onde o problema ocorreu)
- Impacto esperado

Max 3 propostas por retrospectiva. Cada proposta toca exatamente 1 template.

**Etapa 4 — Aprovacao:**
- Apresentar propostas ao usuario
- Aprovada → aplicar no template + registrar em MEMORY_KNOWLEDGE.md
- Rejeitada → registrar motivo (cooldown de 3 sessoes)
- Modificada → aplicar versao do usuario

### Regras de Seguranca

1. NUNCA alterar templates silenciosamente
2. NUNCA alterar CLAUDE.md do Nucleo Workflow (Camada 1 imutavel)
3. Minimo 2 evidencias para propor mudanca
4. Maximo 3 propostas por retrospectiva
5. Cada proposta toca exatamente 1 template
6. Propostas rejeitadas em cooldown de 3 sessoes
7. Versionamento via git history

### Separacao: Retrospectiva vs Workflow-Prompt

- **Retrospectiva**: melhorias incrementais nos templates, baseadas em evidencia
  - Exemplo: "Adicionar parametro ESCALATION_RULES ao brain-skill.tmpl.md"
- **Workflow-Prompt**: mudancas estruturais no Nucleo Workflow em si
  - Exemplo: "Criar novo skill workflow-integration para nucleos com APIs externas"

## 9. Skill Detalhado: workflow-prompt

### Papel

Meta-otimizacao estrutural do proprio Nucleo Workflow. Mudancas deliberadas que afetam a arquitetura do sistema.

### Pre-condicao

Pedido explicito do usuario. Este skill NUNCA e ativado automaticamente.

### Fluxo

1. **Analise do pedido**: identificar o que o usuario quer mudar na estrutura do Nucleo Workflow
2. **Avaliacao de impacto**: mapear quais skills, templates e pipelines sao afetados
3. **Proposta com diff**: apresentar mudanca proposta mostrando antes/depois
4. **Aprovacao**: aguardar aprovacao explicita do usuario
5. **Aplicacao**: implementar a mudanca
6. **Documentacao**: registrar em MEMORY_KNOWLEDGE.md com justificativa

### Escopo (o que FAZ)

- Reestruturar skills existentes (dividir, fundir, renomear)
- Mudar o pipeline principal (adicionar/remover etapas)
- Criar ou remover skills do Nucleo Workflow
- Alterar a logica de routing
- Mudar o formato dos templates

### Limites (o que NAO faz)

- NUNCA altera CLAUDE.md do Nucleo Workflow sem aprovacao (Camada 1 protegida)
- NUNCA faz mudancas incrementais em templates individuais (isso e escopo da retrospectiva)
- NUNCA aplica mudancas silenciosamente

### Post-condicao

Mudanca aplicada, documentada em MEMORY_KNOWLEDGE.md, e commitada via git.

### Separacao da Retrospectiva

| Criterio | Retrospectiva | Workflow-Prompt |
|----------|--------------|-----------------|
| Ativacao | Automatica (3+ nucleos) ou explicita | Apenas explicita |
| Escopo | Regras, itens de checklist, exemplos dentro de templates | Estrutura de skills, pipelines, routing |
| Evidencia | Min 2 nucleos com mesmo problema | Decisao deliberada do usuario |
| Exemplo | "Adicionar parametro ESCALATION_RULES ao template" | "Criar novo skill workflow-integration" |

## 10. Regras Imutaveis do Nucleo Workflow (Camada 1)


1. **NUNCA gerar nucleo sem spec aprovada** — nucleos sem planejamento produzem skills incoerentes
2. **SEMPRE anatomia de 7 secoes em cada brain skill** — consistencia permite comparacao e melhoria sistematica
3. **CLAUDE.md gerado DEVE ter < 100 linhas** — carregado em toda conversa, cada linha consome contexto permanente
4. **Cada skill gerada DEVE ter < 400 linhas** — conteudo pesado vai em references/
5. **NUNCA duplicar regras entre Camada 1 e Camada 2** — duplicacao cria ambiguidade quando versoes divergem
6. **Toda regra gerada DEVE incluir justificativa (WHY)** — regras sem razao sao ignoradas pelo modelo
7. **Templates so mudam via retrospectiva ou workflow-prompt aprovados** — mudancas nao rastreadas degradam qualidade

### Rationalization Table

| Desculpa | Realidade |
|----------|-----------|
| "Esse dominio e simples, nao precisa de tanta estrutura" | Estrutura minima (CLAUDE.md + 2-3 skills + memoria) sempre compensa. Nucleos "simples" que crescem sem estrutura viram monolitos. |
| "Vou gerar as skills direto, sem spec" | Spec forca pensamento sobre routing, pipelines e gates. Sem spec = retrabalho garantido. |
| "Uma skill grande faz mais sentido que varias pequenas" | Skills focadas compoem melhor, consomem menos contexto, e sao mais faceis de iterar. |
| "Nao preciso de validation, vou conferir manualmente" | Validation automatica pega inconsistencias invisiveis ao olho humano. |
| "A memoria e overkill para esse nucleo" | Sem memoria, cada sessao comeca do zero. Mesmo nucleos simples se beneficiam de contexto persistido. |

### Escalation Thresholds

- Validator falha 2x consecutivas no mesmo item → revisar template correspondente
- Dominio nao encaixa em templates existentes → flag usuario, sugerir template custom
- Nucleo com 0 feedback apos 3 sessoes de uso → sugerir retrospectiva

## 11. Protocolo de Inicializacao

1. Ler `.ai/MEMORY_KNOWLEDGE.md` → resumir patterns e anti-patterns em 1-2 linhas
2. Ler `nucleos/registry.md` → quantos nucleos, ultimo gerado
3. Perguntar: "O que criamos hoje?" → routing → ativar skill

Sem apresentacao longa. Sem listar skills. Ir direto ao trabalho.

## 12. Arvore Final de Arquivos

```
~/Desktop/Nucleo Workflow/
├── CLAUDE.md                              Camada 1 (< 100 linhas)
│                                          Routing + pipeline + regras imutaveis
│
├── .claude/skills/
│   ├── workflow-architect/SKILL.md        Analisa dominio (~250 linhas)
│   ├── workflow-generator/SKILL.md        Gera nucleo (~300 linhas)
│   ├── workflow-validator/SKILL.md        Valida qualidade (~200 linhas)
│   ├── workflow-retrospective/SKILL.md    Self-improvement (~200 linhas)
│   └── workflow-prompt/SKILL.md           Meta-otimizacao (~100 linhas)
│
├── templates/
│   ├── claude-md.tmpl.md                  Template CLAUDE.md
│   ├── brain-skill.tmpl.md                Template brain skill
│   ├── memory-knowledge.tmpl.md           Template MEMORY_KNOWLEDGE.md
│   ├── memory-sessions.tmpl.md            Template MEMORY_SESSIONS.md
│   ├── context.tmpl.md                    Template CONTEXT.md
│   └── playbooks.tmpl.md                  Template playbook pipelines
│
├── .ai/
│   ├── CONTEXT.md                         Stack do Nucleo Workflow
│   ├── MEMORY_KNOWLEDGE.md                Patterns e anti-patterns de nucleos
│   └── MEMORY_SESSIONS.md                 Log de sessoes
│
├── nucleos/
│   └── registry.md                        Registro de nucleos gerados
│
└── docs/
    └── superpowers/
        └── specs/
            └── 2026-03-13-nucleo-workflow-design.md
```

## 13. Metricas de Sucesso

| Metrica | Target |
|---------|--------|
| CLAUDE.md gerado | < 100 linhas |
| Skills geradas | < 400 linhas cada |
| Validation pass rate | 100% nos 13 itens |
| Tempo para nucleo completo | Simples: 1 sessao, Medio: 1-2 sessoes, Complexo: 2-3 sessoes |
| Consistencia cross-nucleo | Mesma anatomia, hierarquia, memoria |
| Templates melhorados via retrospectiva | 1+ por 5 nucleos |

## 14. Integracao com Superpowers

| Quando | Skill do Superpowers |
|--------|---------------------|
| Antes de definir spec de nucleo complexo | `brainstorming` |
| Formalizar implementacao do nucleo | `writing-plans` |
| Gerar skills em paralelo | `subagent-driven-development` |
| Antes de declarar nucleo pronto | `verification-before-completion` |
| Isolar trabalho | `using-git-worktrees` |

**Nota:** Todas as integracoes com Superpowers sao opcionais/recomendadas. O Nucleo Workflow funciona de forma autonoma sem elas. Se o plugin Superpowers nao estiver disponivel, o usuario segue o pipeline manualmente.

## 15. Pesquisa Aplicada Incorporada

Tecnicas validadas que fundamentam este design:

### Anthropic Prompt Engineering Best Practices
- Instrucoes positivas > negativas
- Explique o WHY, nao apenas o WHAT
- XML tags para estrutura semantica
- Role com contexto tecnico profundo
- 1-3 exemplos concretos por padrao

### Context Engineering (2025-2026)
- Progressive disclosure: SKILL.md leve, conteudo pesado em references/
- JIT context: carregar apenas o necessario, quando necessario
- Budget de contexto: ~94%+ disponivel para trabalho real

### Decomposed Prompting
- Skill como "decomposer" que delega sub-tarefas
- Handlers especializados (subagents) para tarefas independentes
- Cada handler pode ser testado e otimizado independentemente

### ReAct Pattern
- Verify-Before-Advance: verificar resultado de cada passo antes de avancar
- Ciclo: Pensamento → Acao → Observacao → repetir

### Meta-Prompting
- Templates parametrizados que geram prompts domain-specific
- Scaffold example-agnostic que guia estrutura, nao conteudo

### Patterns Avancados de Skills
- Phase Gates: maquina de estados, nao checklist linear
- Rationalization Tables: previne atalhos do modelo
- Escalation Thresholds: limites concretos para pedir ajuda
- Skill Chaining: integracao natural com ecossistema existente
- Generator-Critic Protocol: handoff com validacao automatica

## 16. Migracao de Conhecimento

O Nucleo Workflow incorpora patterns validados de:

| Fonte | Pattern Extraido |
|-------|-----------------|
| Nucleo Discord v2.0 | Hierarquia 4 camadas, routing semantico, validation gates, Generator-Critic, memoria 2-tier, retrospectiva |
| Nucleo Sobble v1.0 | Progressive disclosure com references/, escala adaptativa, troubleshooting real |
| Sobble prompt-rewrite-skill.md | Phase Gates, Rationalization Tables, Escalation Thresholds, Verify-Before-Advance, Skill Chaining |
| Superpowers (brainstorming, TDD, debugging) | Anatomia de skills, checklist enforcement, pipeline discipline |
| Pesquisa 2025-2026 | Context engineering, decomposed prompting, meta-prompting, self-improving agents |
