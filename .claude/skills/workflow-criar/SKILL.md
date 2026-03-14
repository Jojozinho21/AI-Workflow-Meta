---
name: workflow-criar
description: "Cria um nucleo de AI completo do zero. Ativar para: criar nucleo, novo nucleo, montar workflow, gerar segundo cerebro, criar sistema de AI, novo workflow, montar nucleo."
---

# /workflow-criar — Criar Nucleo

## Papel

Ponto de entrada para criar um nucleo de AI novo do zero.
Roteador que ativa o pipeline completo: architect → generator → validator.

## Pre-condicoes (gate de entrada)

- Usuario descreveu o dominio do nucleo que quer criar
- Se descricao vaga: fazer ate 3 perguntas de esclarecimento antes de iniciar

## Fluxo

O pipeline e automatico. Cada brain tem gates de entrada e saida — so avanca quando pos-condicoes sao cumpridas.

```
📐 FASE 1 — Projetar     → workflow-architect analisa dominio, gera Nucleo Spec
⏸️  GATE                  → Spec aprovada pelo usuario (Status: Approved)
🔨 FASE 2 — Gerar        → workflow-generator transforma spec em arquivos via templates
⏸️  GATE                  → Todos arquivos gerados, nenhum placeholder remanescente
✅ FASE 3 — Validar      → workflow-validator audita 13 criterios de qualidade
🔄 FIX LOOP              → Se falhas: generator corrige, validator re-audita (max 2x)
📋 FASE 4 — Registrar    → Nucleo registrado em nucleos/registry.md, memoria atualizada
```

## Regras

1. SEMPRE executar o pipeline completo (architect → generator → validator) — pular etapas produz nucleo inconsistente ou incompleto
2. NUNCA gerar arquivos sem spec aprovada pelo usuario — spec e o contrato entre o que o usuario quer e o que o sistema entrega
3. Se o usuario ja tem uma spec pronta: pular direto para generator — re-projetar o que ja foi decidido e desperdicio
4. Se o dominio e similar a um nucleo existente no registry: sugerir usar como base — reinventar patterns validados e desperdicio
5. Ao finalizar: registrar nucleo no registry e atualizar memoria — nucleo nao registrado e invisivel para retrospectiva

## Checklist de self-review

- [ ] Pipeline completo executado (architect → generator → validator)?
- [ ] Spec aprovada pelo usuario antes de gerar?
- [ ] Validator passou 13/13 (ou issues corrigidos)?
- [ ] Nucleo registrado em nucleos/registry.md?
- [ ] Memoria atualizada (MEMORY_KNOWLEDGE + MEMORY_SESSIONS)?

## Post-condicoes (gate de saida)

- Nucleo completo gerado no workspace de destino
- Validator passou 13/13 criterios
- Nucleo registrado em `nucleos/registry.md` com Status: Active
- Sessao registrada em `MEMORY_SESSIONS.md`

## Criterios de handoff

- **13/13 PASS** → nucleo pronto para uso. DONE.
- **Validator falhou apos 2 iteracoes** → escalar ao usuario com issues especificos
- **Usuario cancela no meio** → registrar estado parcial no registry com Status: Cancelled
