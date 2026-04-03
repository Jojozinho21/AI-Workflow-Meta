---
name: workflow-criar
description: "Cria um nucleo de AI completo do zero, ou um workflow operacional para empresas. Ativar para: criar nucleo, novo nucleo, montar workflow, gerar segundo cerebro, criar sistema de AI, novo workflow, montar nucleo, workflow para empresa, criar workflow empresarial, workflow de produtividade, workflow para time."
---

# /workflow-criar — Criar Nucleo ou Workflow

## Papel

Ponto de entrada para criar um nucleo de AI novo do zero, ou um workflow operacional para empresas e times.
Detecta o tipo de dominio e ativa o pipeline correto.

## Pre-condicoes (gate de entrada)

- Usuario descreveu o que quer criar
- Se descricao vaga: perguntar se e um **nucleo de AI** (para desenvolvimento) ou um **workflow para empresa** (para otimizar processos)

## Detectar tipo de dominio

Antes de iniciar o pipeline, classificar:

| Sinais | Tipo | Pipeline |
|--------|------|----------|
| "bot", "plugin", "sistema de AI", "segundo cerebro", "nucleo" | Dev/AI | Pipeline Dev |
| "empresa", "time", "processo", "produtividade", "SOP", "onboarding", "vendas", "RH", "operacao" | Empresarial | Pipeline Business |

Se ambiguo: perguntar ao usuario antes de iniciar.

## Fluxo — Pipeline Dev (nucleo de AI)

```
📐 FASE 1 — Projetar     → workflow-architect analisa dominio, gera Nucleo Spec
⏸️  GATE                  → Spec aprovada pelo usuario (Status: Approved)
🔨 FASE 2 — Gerar        → workflow-generator transforma spec em workspace de AI
⏸️  GATE                  → Todos arquivos gerados, nenhum placeholder remanescente
✅ FASE 3 — Validar      → workflow-validator audita criterios de qualidade
🔄 FIX LOOP              → Se falhas: generator corrige, validator re-audita (max 2x)
📋 FASE 4 — Registrar    → Nucleo registrado em nucleos/registry.md
```

## Fluxo — Pipeline Business (workflow para empresa)

```
🏢 FASE 1 — Intake       → workflow-business entende a empresa (setor, processos, dores, ferramentas)
⏸️  GATE                  → Business Workflow Spec aprovada pelo usuario (Status: Approved)
📐 FASE 2 — Projetar     → workflow-architect expande spec em Business Workflow Design completo
⏸️  GATE                  → Design aprovado pelo usuario (Status: Approved)
🔨 FASE 3 — Gerar        → workflow-generator gera documentos operacionais (workflow.md, sop.md, checklists, metricas)
📋 FASE 4 — Registrar    → Workflow registrado em nucleos/registry.md como tipo Business Workflow
```

## Regras

1. SEMPRE detectar o tipo de dominio antes de iniciar — pipeline errado produz output inutilizavel
2. SEMPRE executar o pipeline completo — pular etapas produz output inconsistente ou incompleto
3. NUNCA gerar arquivos sem spec/design aprovado pelo usuario — e o contrato entre o que o usuario quer e o que o sistema entrega
4. Se o usuario ja tem uma spec pronta: pular direto para generator — re-projetar o que ja foi decidido e desperdicio
5. Se o dominio e similar a um nucleo/workflow existente no registry: sugerir usar como base — reinventar patterns validados e desperdicio
6. Ao finalizar: registrar no registry e atualizar memoria — output nao registrado e invisivel para retrospectiva
7. Pipeline Business NAO gera SKILL.md, CLAUDE.md ou workspace de AI — output sao documentos operacionais humanos

## Checklist de self-review

- [ ] Tipo de dominio detectado (Dev/AI ou Empresarial)?
- [ ] Pipeline correto executado?
- [ ] Spec/Design aprovado pelo usuario antes de gerar?
- [ ] Output registrado em nucleos/registry.md?
- [ ] Memoria atualizada (MEMORY_KNOWLEDGE + MEMORY_SESSIONS)?

**Adicional para Pipeline Dev:**
- [ ] Validator passou criterios de qualidade (ou issues corrigidos)?

## Post-condicoes (gate de saida)

**Pipeline Dev:**
- Nucleo completo gerado no workspace de destino
- Validator passou criterios de qualidade
- Registrado em `nucleos/registry.md` com Status: Active

**Pipeline Business:**
- Pasta com workflow.md, sop.md, checklists/, templates/, metricas.md gerada
- Registrado em `nucleos/registry.md` como tipo: Business Workflow, Status: Active

## Criterios de handoff

- **Pipeline Dev completo** → nucleo pronto para uso. DONE.
- **Pipeline Business completo** → documentos de workflow prontos para uso. DONE.
- **Validator falhou apos 2 iteracoes (Dev)** → escalar ao usuario com issues especificos
- **Usuario cancela no meio** → registrar estado parcial no registry com Status: Cancelled
