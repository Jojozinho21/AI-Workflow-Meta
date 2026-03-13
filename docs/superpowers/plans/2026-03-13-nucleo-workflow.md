# Nucleo Workflow Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a meta-workflow workspace that generates consistent, structured AI nucleos for any domain using parametrized templates, validation gates, and self-improvement.

**Architecture:** Workspace at `~/Desktop/Nucleo Workflow/` with CLAUDE.md as compact dispatcher (<100 lines), 5 Claude Code skills for the pipeline (architect → generator → validator → retrospective → prompt), 6 parametrized templates, structured memory in `.ai/`, and a registry of generated nucleos. All content is markdown — no executable code.

**Tech Stack:** Claude Code skills (SKILL.md), Markdown templates with `{{PLACEHOLDER}}` syntax, git for versioning.

**Spec:** `docs/superpowers/specs/2026-03-13-nucleo-workflow-design.md`

**Language:** All files in Portuguese Brazilian (matching existing nucleos).

---

## File Structure

```
~/Desktop/Nucleo Workflow/
├── CLAUDE.md                                    # Camada 1 dispatcher (<100 lines)
├── .claude/skills/
│   ├── workflow-architect/SKILL.md              # Domain analysis + spec generation (~250 lines)
│   ├── workflow-generator/SKILL.md              # Template-based nucleo generation (~300 lines)
│   ├── workflow-validator/SKILL.md              # 13-item quality validation (~200 lines)
│   ├── workflow-retrospective/SKILL.md          # Self-improvement loop (~200 lines)
│   └── workflow-prompt/SKILL.md                 # Structural meta-optimization (~100 lines)
├── templates/
│   ├── claude-md.tmpl.md                        # Template for generated CLAUDE.md
│   ├── brain-skill.tmpl.md                      # Template for generated brain skills
│   ├── memory-knowledge.tmpl.md                 # Template for MEMORY_KNOWLEDGE.md
│   ├── memory-sessions.tmpl.md                  # Template for MEMORY_SESSIONS.md
│   ├── context.tmpl.md                          # Template for CONTEXT.md
│   └── playbooks.tmpl.md                        # Template for playbook pipelines
├── .ai/
│   ├── CONTEXT.md                               # Stack context for Nucleo Workflow itself
│   ├── MEMORY_KNOWLEDGE.md                      # Patterns and anti-patterns
│   └── MEMORY_SESSIONS.md                       # Session log
├── nucleos/
│   └── registry.md                              # Registry of generated nucleos
└── docs/superpowers/
    ├── specs/2026-03-13-nucleo-workflow-design.md
    └── plans/2026-03-13-nucleo-workflow.md
```

---

## Chunk 1: Foundation

### Task 1: Initialize Git Repository

**Files:**
- Create: `.gitignore`

- [ ] **Step 1: Initialize git repo**

```bash
cd ~/Desktop/Nucleo\ Workflow
git init
```

- [ ] **Step 2: Create .gitignore**

```
.DS_Store
*.swp
*~
```

- [ ] **Step 3: Commit**

```bash
git add .gitignore docs/
git commit -m "chore: init repo with design spec and plan"
```

### Task 2: Create CLAUDE.md (Camada 1 — Dispatcher)

**Files:**
- Create: `CLAUDE.md`

This is the most critical file — loaded in EVERY conversation. Must be <100 lines. Contains identity, 7 immutable rules, routing table, pipelines, init protocol, and memory pointers. NO domain-specific content — that lives in skills.

Reference: `Nucleo Discord/CLAUDE.md` (77 lines) for the pattern.

- [ ] **Step 1: Write CLAUDE.md**

Content must include these exact sections in order:
1. **Identidade** (3-4 lines): workspace name, owner, domain description
2. **Regras Imutaveis (Camada 1)** (7 numbered rules from spec Section 10, each with WHY as inline comment)
3. **Routing de Skills** (table: Tipo de tarefa | Skill — from spec Section 4.2)
4. **Playbook Pipelines** (3 pipelines from spec Section 4.3: Criar Nucleo, Melhorar Templates, Meta-Otimizacao)
5. **Inicializacao de Sessao** (3 steps from spec Section 11)
6. **Contexto do Projeto** (pointers to .ai/ files and templates/)
7. **Memoria — Regras de Escrita** (immediate vs batch, end-of-session rules from spec)

Constraints:
- < 100 lines total
- Every rule includes justificativa inline (ex: `— porque X`)
- Routing table must reference all 5 skills
- No art, no intro paragraph, no listing of skills
- Rationalization Table and Escalation Thresholds do NOT go in CLAUDE.md (too long) — they live in the workflow-validator and workflow-architect skills respectively, where they're loaded on demand

- [ ] **Step 2: Verify line count**

```bash
wc -l CLAUDE.md
```

Expected: < 100 lines

- [ ] **Step 3: Commit**

```bash
git add CLAUDE.md
git commit -m "feat: add CLAUDE.md dispatcher (Camada 1)"
```

### Task 3: Create .ai/ Context and Memory Files

**Files:**
- Create: `.ai/CONTEXT.md`
- Create: `.ai/MEMORY_KNOWLEDGE.md`
- Create: `.ai/MEMORY_SESSIONS.md`

- [ ] **Step 1: Write `.ai/CONTEXT.md`**

Content:
```markdown
# Nucleo Workflow — Contexto

## Stack
- Plataforma: Claude Code Skills (SKILL.md)
- Formato: Markdown com templates parametrizados ({{PLACEHOLDER}})
- Versionamento: Git
- Linguagem dos nucleos gerados: Portugues Brasileiro

## Ferramentas
- Claude Code (skills, subagents, worktrees)
- Superpowers plugin (brainstorming, writing-plans, verification — opcionais)

## Convencoes
- CLAUDE.md < 100 linhas
- Skills < 400 linhas
- Anatomia de brain skills: 7 secoes (Papel, Pre-condicoes, Regras, Templates, Checklist, Post-condicoes, Handoff)
- Memoria estruturada: tabelas e bullets, nunca paragrafos
- Toda regra com justificativa (WHY)
- Templates usam {{PLACEHOLDER}} como marcadores parametrizados
```

- [ ] **Step 2: Write `.ai/MEMORY_KNOWLEDGE.md`**

Content (empty schema ready for use):
```markdown
# Nucleo Workflow — Conhecimento Persistente

## Decisoes Ativas

| Decisao | Justificativa | Data | Status |
|---------|---------------|------|--------|

## Entidades do Projeto

| Entidade | Tipo | Detalhe |
|----------|------|---------|

## Padroes Validados

## Anti-Padroes Descobertos

## Issues Conhecidos
```

- [ ] **Step 3: Write `.ai/MEMORY_SESSIONS.md`**

Content:
```markdown
# Nucleo Workflow — Log de Sessoes

<!-- Max 5 bullets por sessao. Ultimas 10 detalhadas. Mais antigas comprimidas em ## Arquivo -->
```

- [ ] **Step 4: Commit**

```bash
git add .ai/
git commit -m "feat: add .ai/ context and memory files"
```

### Task 4: Create Nucleos Registry

**Files:**
- Create: `nucleos/registry.md`

- [ ] **Step 1: Write `nucleos/registry.md`**

Content:
```markdown
# Registro de Nucleos Gerados

| Nucleo | Dominio | Brains | Data | Caminho | Status | Feedback |
|--------|---------|--------|------|---------|--------|----------|
```

- [ ] **Step 2: Commit**

```bash
git add nucleos/
git commit -m "feat: add nucleos registry"
```

---

## Chunk 2: Templates

### Task 5: Create claude-md.tmpl.md

**Files:**
- Create: `templates/claude-md.tmpl.md`

This template generates the CLAUDE.md for a target nucleo. It must follow the same structure as the Nucleo Workflow's own CLAUDE.md but with parametrized values.

Reference: Nucleo Discord CLAUDE.md (77 lines) and Nucleo Workflow CLAUDE.md (Task 2).

- [ ] **Step 1: Write template**

The template must include:
- Header comment explaining this is a template and listing all parameters
- `{{WORKSPACE_NAME}}` — name of the nucleo workspace
- `{{DOMAIN}}` — domain description
- `{{OWNER}}` — owner name
- `{{IMMUTABLE_RULES}}` — 5-10 numbered rules with WHY, inserted as block
- `{{ROUTING_TABLE}}` — markdown table (Tipo de tarefa | Skill)
- `{{PLAYBOOKS}}` — pipeline definitions with `→` notation
- `{{INIT_PROTOCOL}}` — initialization steps (default: 3-step from spec Section 11)
- `{{MEMORY_POINTERS}}` — paths to .ai/ files
- `{{MEMORY_RULES}}` — immediate vs batch write rules

Structure of generated output:
```
## Identidade
## Regras Imutaveis (Camada 1)
## Routing de Brains
## Playbook Pipelines
## Inicializacao de Sessao
## Contexto do Projeto
## Memoria — Regras de Escrita
```

Target: generated CLAUDE.md < 100 lines

- [ ] **Step 2: Commit**

```bash
git add templates/claude-md.tmpl.md
git commit -m "feat: add CLAUDE.md template"
```

### Task 6: Create brain-skill.tmpl.md

**Files:**
- Create: `templates/brain-skill.tmpl.md`

This is the most important template — generates each brain skill with the standard 7-section anatomy.

Reference: `Nucleo Discord/.claude/skills/brain-architect/SKILL.md` (124 lines) and `brain-dev/SKILL.md` (138 lines).

- [ ] **Step 1: Write template**

Parameters:
- `{{BRAIN_NAME}}` — lowercase with hyphens (ex: brain-architect)
- `{{BRAIN_DESCRIPTION}}` — 1-2 sentence description for frontmatter with 3+ trigger phrases
- `{{ROLE}}` — 1-2 sentence role description
- `{{PRECONDITIONS}}` — list of entry gates
- `{{RULES}}` — 10-15 numbered rules, each with WHY
- `{{OUTPUT_TEMPLATES}}` — max 2 code/format examples
- `{{SELF_REVIEW}}` — checklist items as `- [ ]` entries
- `{{POSTCONDITIONS}}` — exit gates
- `{{HANDOFF_CRITERIA}}` — when and to whom to hand off

Structure of generated output (7 sections):
```yaml
---
name: {{BRAIN_NAME}}
description: "{{BRAIN_DESCRIPTION}}"
---

# {{BRAIN_NAME}} — {{DOMAIN}}

## Papel
## Pre-condicoes (gate de entrada)
## Regras
## Templates de output
## Checklist de self-review
## Post-condicoes (gate de saida)
## Criterios de handoff
```

Target: 150-300 lines per generated brain

- [ ] **Step 2: Commit**

```bash
git add templates/brain-skill.tmpl.md
git commit -m "feat: add brain skill template (7-section anatomy)"
```

### Task 7: Create Memory and Context Templates

**Files:**
- Create: `templates/memory-knowledge.tmpl.md`
- Create: `templates/memory-sessions.tmpl.md`
- Create: `templates/context.tmpl.md`
- Create: `templates/playbooks.tmpl.md`

- [ ] **Step 1: Write `memory-knowledge.tmpl.md`**

Fixed schema with 5 sections (Decisoes Ativas, Entidades, Padroes Validados, Anti-Padroes, Issues). Soft limit 100 lines, hard limit 150. Same format as `.ai/MEMORY_KNOWLEDGE.md` but generic.

- [ ] **Step 2: Write `memory-sessions.tmpl.md`**

Format per session: `## YYYY-MM-DD — [Projeto]: [Resumo]` + max 5 bullets. Max 10 detailed sessions. Includes `## Arquivo` section for compressed older sessions.

- [ ] **Step 3: Write `context.tmpl.md`**

Parameters:
- `{{STACK}}` — language, framework, versions
- `{{BUILD_TOOL}}` — Maven, npm, etc.
- `{{TEST_FRAMEWORK}}` — JUnit, Vitest, Jest, etc.
- `{{DATABASE}}` — if applicable
- `{{INTEGRATIONS}}` — external APIs/services
- `{{CONVENTIONS}}` — domain patterns and conventions

- [ ] **Step 4: Write `playbooks.tmpl.md`**

Parameters:
- `{{PIPELINES}}` — list of pipelines, each with:
  - `{{PIPELINE_NAME}}` — descriptive name
  - `{{BRAIN_SEQUENCE}}` — ordered list with `→` notation
  - `{{GATE_CONDITIONS}}` — transition conditions (optional, defaults to pre/post-conditions)

Output format: compact block to be inserted into CLAUDE.md Playbook section.

- [ ] **Step 5: Commit**

```bash
git add templates/memory-knowledge.tmpl.md templates/memory-sessions.tmpl.md templates/context.tmpl.md templates/playbooks.tmpl.md
git commit -m "feat: add memory, context, and playbooks templates"
```

---

## Chunk 3: Core Pipeline Skills

### Task 8: Create workflow-architect Skill

**Files:**
- Create: `.claude/skills/workflow-architect/SKILL.md`

The architect analyzes a domain description and generates a Nucleo Spec. This is the entry point of the pipeline.

Reference: Spec Section 5 (detailed flow), Spec Section 4.6 (anatomy), `Nucleo Discord/brain-architect/SKILL.md` (style).

- [ ] **Step 1: Write SKILL.md**

Frontmatter:
```yaml
---
name: workflow-architect
description: "Analisa dominios e gera specs completas para novos nucleos de AI. Ativar para: criar nucleo novo, descrever dominio, planejar nucleo, projetar workflow, definir segundo cerebro, montar sistema de AI."
---
```

Body must include ALL 7 sections:

**1. Papel** (2 lines): Analisa dominios e gera Nucleo Specs completas para qualquer tipo de nucleo.

**2. Pre-condicoes** (from spec Section 4.4):
- Descricao do dominio recebida do usuario
- Se descricao vaga: ate 3 perguntas de esclarecimento

**3. Regras** (10-15, each with WHY):
- Analise de dominio: identificar entidades, acoes, ciclos de trabalho
- Classificacao de complexidade (Simples/Medio/Complexo with thresholds)
- Identificacao de brains: quais cerebros o nucleo precisa
- Cada brain deve ter papel, triggers, pre/post-condicoes claros
- Routing semantico: cobrir todas as tarefas possiveis do dominio
- Playbook pipelines: definir sequencia logica para cada workflow
- Regras imutaveis: 5-10 regras especificas do dominio, cada uma com WHY
- NUNCA gerar arquivos neste skill — apenas a spec
- Ler nucleos existentes no registry para reusar patterns
- Considerar necessidade de integracoes externas

**4. Templates de output**: Include the Nucleo Spec Format from spec Section 5 (complete markdown template with all sections)

**5. Checklist de self-review**:
- [ ] Todos os brains tem papel e triggers definidos?
- [ ] Routing cobre todas as tarefas possiveis do dominio?
- [ ] Playbooks tem sequencia logica com gates?
- [ ] Regras imutaveis tem justificativa (WHY)?
- [ ] Complexidade classificada corretamente?
- [ ] Status = Draft (usuario ainda nao aprovou)?
- [ ] Nenhum placeholder vazio na spec?

**6. Post-condicoes**: Nucleo Spec escrita com Status: Draft, apresentada ao usuario, marcada Approved apos aprovacao explicita.

**7. Criterios de handoff**: Apos aprovacao → workflow-generator

Target: ~250 lines

- [ ] **Step 2: Verify line count**

```bash
wc -l .claude/skills/workflow-architect/SKILL.md
```

Expected: 200-300 lines

- [ ] **Step 3: Commit**

```bash
git add .claude/skills/workflow-architect/
git commit -m "feat: add workflow-architect skill"
```

### Task 9: Create workflow-generator Skill

**Files:**
- Create: `.claude/skills/workflow-generator/SKILL.md`

The generator takes an approved Nucleo Spec and generates all files using templates. This is the factory.

Reference: Spec Section 6 (detailed flow, templates, process), Spec Section 4.6 (anatomy).

- [ ] **Step 1: Write SKILL.md**

Frontmatter:
```yaml
---
name: workflow-generator
description: "Gera todos os arquivos de um nucleo a partir de spec aprovada e templates parametrizados. Ativar para: gerar nucleo, criar arquivos do nucleo, montar workspace, construir segundo cerebro a partir de spec."
---
```

Body must include ALL 7 sections:

**1. Papel** (2 lines): Pega Nucleo Spec aprovada e gera todos os arquivos usando templates parametrizados.

**2. Pre-condicoes**: Nucleo Spec com `Status: Approved`

**3. Regras** (12-15, each with WHY):
- Ler Nucleo Spec completamente antes de gerar
- Perguntar caminho de destino ao usuario (ou inferir: `~/Desktop/Nucleo {{NOME}}/`)
- Para cada brain na spec: gerar SKILL.md usando `templates/brain-skill.tmpl.md`
- Gerar CLAUDE.md usando `templates/claude-md.tmpl.md` — DEVE ter < 100 linhas
- Gerar .ai/CONTEXT.md, MEMORY_KNOWLEDGE.md, MEMORY_SESSIONS.md usando templates
- Gerar playbooks e inserir no CLAUDE.md
- Criar estrutura de diretorios: `.claude/skills/`, `.ai/`
- Self-review: verificar que TODOS os brains da spec tem skills gerados
- Registrar nucleo em `nucleos/registry.md` com data, caminho, status
- NUNCA deixar {{PLACEHOLDER}} sem preencher — se falta dado, perguntar ao usuario
- Descriptions de cada brain devem ter 3+ trigger phrases variadas
- Cada regra gerada deve ter WHY inline
- Nenhum TODO/placeholder no output final

**4. Templates de output**: Example showing a filled template vs raw template (1 example)

**5. Checklist de self-review**:
- [ ] Todos os brains da spec tem skills gerados?
- [ ] CLAUDE.md < 100 linhas?
- [ ] Cada skill < 400 linhas?
- [ ] Nenhum {{PLACEHOLDER}} sem preencher?
- [ ] Routing table cobre todos os brains?
- [ ] Playbooks referenciam apenas brains existentes?
- [ ] .ai/ files criados com schema correto?
- [ ] Nucleo registrado em registry.md?

**6. Post-condicoes**: Todos os arquivos gerados, self-review completo, nucleo registrado.

**7. Criterios de handoff**: Apos geracao → workflow-validator

Target: ~300 lines

- [ ] **Step 2: Verify line count**

```bash
wc -l .claude/skills/workflow-generator/SKILL.md
```

Expected: 250-350 lines

- [ ] **Step 3: Commit**

```bash
git add .claude/skills/workflow-generator/
git commit -m "feat: add workflow-generator skill"
```

### Task 10: Create workflow-validator Skill

**Files:**
- Create: `.claude/skills/workflow-validator/SKILL.md`

The validator applies 13 quality checks to a generated nucleo. This is the critic in the Generator-Critic protocol.

Reference: Spec Section 7 (13 items, process), Spec Section 4.5 (Generator-Critic protocol).

- [ ] **Step 1: Write SKILL.md**

Frontmatter:
```yaml
---
name: workflow-validator
description: "Valida qualidade e consistencia de nucleos gerados. Ativar para: validar nucleo, checar qualidade, revisar nucleo gerado, verificar consistencia, auditar nucleo."
---
```

Body must include ALL 7 sections:

**1. Papel** (2 lines): Valida qualidade e consistencia de nucleos gerados aplicando 13 itens de verificacao.

**2. Pre-condicoes**: Nucleo gerado (arquivos existem no caminho de destino)

**3. Regras** — This skill's rules ARE the 13 validation items (from spec Section 7):
Each item is a rule with HOW to check and WHAT to do if it fails:

1. CLAUDE.md < 100 linhas — contar com `wc -l`, se exceder: identificar secoes que podem ser compactadas
2. Cada skill < 400 linhas — contar cada SKILL.md, se exceder: sugerir mover conteudo pesado para references/
3. Frontmatter correto — verificar `---` delimiters, `name` e `description` presentes
4. Description com 3+ trigger phrases — contar frases de ativacao distintas na description
5. Zero duplicacao entre CLAUDE.md e skills — comparar regras, flaggear qualquer regra que apareca em ambos
6. Pre-condicoes em cada brain — verificar secao "Pre-condicoes" existe em cada SKILL.md
7. Post-condicoes em cada brain — verificar secao "Post-condicoes" existe
8. Checklist de self-review em cada brain — verificar secao "Checklist" existe com `- [ ]` items
9. Routing cobre todos brains — extrair brains do routing table e comparar com skills existentes
10. Playbooks referenciam brains existentes — extrair nomes dos playbooks e verificar contra skills
11. Memoria com schema rigido — verificar tabelas markdown e bullets, nao paragrafos
12. Nenhum placeholder/TODO — buscar `{{`, `TODO`, `FIXME`, `placeholder` em todos arquivos
13. Regras com WHY — verificar que regras numeradas tem justificativa apos `—`

**4. Templates de output**: Validation report format:
```markdown
## Validation Report — {{NUCLEO_NAME}}

**Data**: YYYY-MM-DD
**Status**: PASSED / FAILED (N/13)

### Resultados
| # | Item | Status | Detalhe |
|---|------|--------|---------|
| 1 | CLAUDE.md < 100 linhas | PASS/FAIL | X linhas |
...

### Issues (se houver)
- **Item N**: [descricao] → [sugestao de fix]
```

**5. Checklist de self-review**:
- [ ] Todos 13 itens verificados?
- [ ] Cada falha tem sugestao de fix?
- [ ] Report entregue ao usuario ou ao workflow-generator?

**6. Post-condicoes**: 13/13 passando, ou lista de issues entregue.

**7. Criterios de handoff**:
- 13/13 PASS → nucleo aprovado, atualizar registry.md com Status: Active
- Issues encontrados → devolver para workflow-generator (max 2 iteracoes)
- Apos 2 iteracoes com falhas → escalar ao usuario com issues especificos

Target: ~200 lines

- [ ] **Step 2: Verify line count**

```bash
wc -l .claude/skills/workflow-validator/SKILL.md
```

Expected: 150-250 lines

- [ ] **Step 3: Commit**

```bash
git add .claude/skills/workflow-validator/
git commit -m "feat: add workflow-validator skill (13-item quality gate)"
```

---

## Chunk 4: Meta Skills

### Task 11: Create workflow-retrospective Skill

**Files:**
- Create: `.claude/skills/workflow-retrospective/SKILL.md`

Self-improvement loop that analyzes generated nucleos and proposes template improvements.

Reference: Spec Section 8 (complete pipeline, rules, separation from prompt).

- [ ] **Step 1: Write SKILL.md**

Frontmatter:
```yaml
---
name: workflow-retrospective
description: "Analisa nucleos gerados anteriormente e propoe melhorias nos templates. Ativar para: retrospectiva, melhorar templates, o que aprendemos, analisar nucleos anteriores, otimizar templates."
---
```

Body — 7 sections following spec Section 8:

**1. Papel**: Analisa nucleos gerados e propoe melhorias incrementais nos templates.

**2. Pre-condicoes**: 3+ nucleos no registry.md, OU pedido explicito do usuario

**3. Regras** (7 rules from spec Section 8 "Regras de Seguranca" + process rules):
- Pipeline de 4 etapas: Coleta → Diagnostico → Propostas → Aprovacao
- Coleta: ler registry.md, MEMORY_KNOWLEDGE.md, ultimas sessoes
- Diagnostico: categorizar em falhas repetidas, friccoes, sucessos
- Max 3 propostas por retrospectiva
- Cada proposta toca exatamente 1 template
- Min 2 evidencias por proposta
- NUNCA alterar templates silenciosamente
- NUNCA alterar CLAUDE.md do Nucleo Workflow
- Propostas rejeitadas em cooldown de 3 sessoes
- Registrar toda proposta (aprovada ou rejeitada) em MEMORY_KNOWLEDGE.md

**4. Templates de output**: Proposal format:
```markdown
### Proposta N: [titulo curto]
- **Template afetado**: [nome do template]
- **Tipo**: [novo parametro / nova secao / ajuste de wording / nova regra]
- **Mudanca**: [diff concreto — antes vs depois]
- **Evidencia**: [nucleos N e M tiveram problema X]
- **Impacto**: [o que melhora]
```

**5. Checklist**: Propostas tem evidencia? Max 3? Cooldown respeitado?

**6. Post-condicoes**: Propostas apresentadas, aprovadas/rejeitadas registradas.

**7. Handoff**: Apos aplicar mudancas → DONE. Se mudanca estrutural necessaria → sugerir workflow-prompt.

Target: ~200 lines

- [ ] **Step 2: Verify line count**

```bash
wc -l .claude/skills/workflow-retrospective/SKILL.md
```

Expected: 150-250 lines

- [ ] **Step 3: Commit**

```bash
git add .claude/skills/workflow-retrospective/
git commit -m "feat: add workflow-retrospective skill (self-improvement loop)"
```

### Task 12: Create workflow-prompt Skill

**Files:**
- Create: `.claude/skills/workflow-prompt/SKILL.md`

Structural meta-optimization of the Nucleo Workflow itself. Only activated by explicit user request.

Reference: Spec Section 9 (complete flow, scope, limits, separation table).

- [ ] **Step 1: Write SKILL.md**

Frontmatter:
```yaml
---
name: workflow-prompt
description: "Meta-otimizacao estrutural do Nucleo Workflow. Ativar para: mudar estrutura do sistema, reestruturar skills, alterar pipeline, modificar routing, criar ou remover skills do Nucleo Workflow."
---
```

Body — 7 sections:

**1. Papel**: Meta-otimizacao estrutural do Nucleo Workflow. Mudancas deliberadas na arquitetura.

**2. Pre-condicoes**: Pedido explicito do usuario. NUNCA ativado automaticamente.

**3. Regras**:
- Fluxo de 6 etapas: Analise → Impacto → Proposta com diff → Aprovacao → Aplicacao → Documentacao
- NUNCA alterar CLAUDE.md sem aprovacao
- NUNCA fazer mudancas incrementais (escopo da retrospectiva)
- NUNCA aplicar silenciosamente
- Escopo: reestruturar skills, mudar pipeline, criar/remover skills, alterar routing, mudar templates
- Include separation table (Retrospectiva vs Prompt) from spec Section 9

**4. Templates**: Before/after diff format

**5. Checklist**: Impacto mapeado? Diff claro? Aprovacao obtida? Documentado?

**6. Post-condicoes**: Mudanca aplicada, documentada, commitada.

**7. Handoff**: DONE apos documentacao.

Target: ~100 lines

- [ ] **Step 2: Verify line count**

```bash
wc -l .claude/skills/workflow-prompt/SKILL.md
```

Expected: 80-120 lines

- [ ] **Step 3: Commit**

```bash
git add .claude/skills/workflow-prompt/
git commit -m "feat: add workflow-prompt skill (structural meta-optimization)"
```

---

## Chunk 5: Self-Validation and Final Commit

### Task 13: Self-Validate the Nucleo Workflow

**Files:**
- Modify: `nucleos/registry.md` (add Nucleo Workflow itself as first entry)

Apply the 13 validation items from workflow-validator to the Nucleo Workflow itself (eating our own dogfood).

- [ ] **Step 1: Validate CLAUDE.md < 100 lines**

```bash
wc -l ~/Desktop/Nucleo\ Workflow/CLAUDE.md
```

- [ ] **Step 2: Validate each skill < 400 lines**

```bash
wc -l ~/Desktop/Nucleo\ Workflow/.claude/skills/*/SKILL.md
```

- [ ] **Step 3: Validate frontmatter in each skill**

Read each SKILL.md and verify `---` delimiters, `name` and `description` fields present.

- [ ] **Step 4: Validate descriptions have 3+ trigger phrases**

Read each description and count distinct trigger phrases.

- [ ] **Step 5: Validate no rule duplication between CLAUDE.md and skills**

Compare rules in CLAUDE.md against rules in each skill. Flag any overlap.

- [ ] **Step 6: Validate anatomy of all skills**

Each skill must have all 7 sections: Papel, Pre-condicoes, Regras, Templates, Checklist, Post-condicoes, Handoff.

- [ ] **Step 7: Validate routing covers all skills**

Extract skill names from routing table in CLAUDE.md. Compare against `.claude/skills/*/`.

- [ ] **Step 8: Validate playbooks reference existing skills**

Extract skill names from playbook pipelines. Verify each exists.

- [ ] **Step 9: Validate memory uses rigid schema**

Check `.ai/MEMORY_KNOWLEDGE.md` uses tables and bullets, not paragraphs.

- [ ] **Step 10: Validate no placeholders**

```bash
grep -r "{{" ~/Desktop/Nucleo\ Workflow/ --include="*.md" | grep -v "templates/" | grep -v "plans/" | grep -v "specs/"
```

Should return no results (templates/ is exempt — they're supposed to have placeholders).

- [ ] **Step 11: Validate rules have WHY**

Check that numbered rules in CLAUDE.md and skills have justificativa after `—`.

- [ ] **Step 12: Fix any issues found**

If any validation item fails, fix it before proceeding.

- [ ] **Step 13: Register Nucleo Workflow itself in registry**

Add to `nucleos/registry.md`:
```
| Nucleo Workflow | Meta-workflow | 5 skills | 2026-03-13 | ~/Desktop/Nucleo Workflow/ | Active | Self-validated |
```

- [ ] **Step 14: Final commit**

```bash
git add -A
git commit -m "feat: self-validate and register Nucleo Workflow in registry"
```

### Task 14: Final Verification

- [ ] **Step 1: Verify file tree matches spec**

```bash
find ~/Desktop/Nucleo\ Workflow -name "*.md" | sort
```

Compare against spec Section 12 (Arvore Final de Arquivos).

- [ ] **Step 2: Verify git log**

```bash
git log --oneline
```

Expected: 8-10 commits tracking incremental progress.

- [ ] **Step 3: Confirm done**

Report validation results to user. The Nucleo Workflow is ready to generate its first nucleo.
