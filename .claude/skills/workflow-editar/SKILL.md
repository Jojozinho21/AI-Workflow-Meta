---
name: workflow-editar
description: "Edita nucleos de AI existentes — adiciona brains, modifica skills, ajusta routing ou templates. Ativar para: editar nucleo, modificar workflow, adicionar brain, ajustar nucleo existente, mudar skill, atualizar nucleo."
---

# /workflow-editar — Editar Nucleo

## Papel

Ponto de entrada para editar nucleos de AI existentes.
Mapeia o nucleo atual, entende a mudanca desejada, e aplica com minimo blast radius.

## Pre-condicoes (gate de entrada)

- Nucleo existente com caminho informado pelo usuario ou disponivel em `nucleos/registry.md`
- Se caminho nao encontrado: perguntar ao usuario
- Descricao da edicao desejada (o que mudar, adicionar ou remover)

## Fluxo

```
🔍 FASE 1 — Mapear       → Le o nucleo, entende arquitetura, brains, routing, pipelines
🛡️ FASE 2 — Proteger      → Identifica blast radius, preserva o que funciona
✏️ FASE 3 — Editar        → Aplica mudanca minima seguindo convencoes do nucleo original
✅ FASE 4 — Validar       → workflow-validator audita 13 criterios no nucleo editado
```

## Regras

1. LER o nucleo COMPLETAMENTE antes de editar — editar sem entender a arquitetura existente quebra consistencia
2. Mapear TODOS os brains, routing e pipelines antes de tocar qualquer arquivo — mudanca em um brain pode afetar routing e pipelines
3. Seguir convencoes do nucleo original (nomes, estilo, linguagem) — inconsistencia entre brains confunde o modelo
4. Blast radius minimo: mudar APENAS o necessario — edicoes desnecessarias introduzem regressoes
5. Se adicionar brain novo: atualizar routing table E playbooks no CLAUDE.md — brain sem routing nunca e ativado
6. Se remover brain: verificar que nenhum playbook ou routing depende dele — remocao sem verificacao quebra pipelines
7. SEMPRE rodar validator apos edicao — edicao sem validacao pode degradar o nucleo
8. NUNCA sobrescrever MEMORY_KNOWLEDGE.md ou MEMORY_SESSIONS.md do nucleo — memoria contem historico que nao pode ser recriado
9. Se mudanca e estrutural (pipeline, routing, criar/remover brains): confirmar com usuario antes — mudancas estruturais tem alto impacto

## Tipos de edicao suportados

| Edicao | O que muda |
|:-------|:-----------|
| Adicionar brain | Nova skill + routing + playbooks |
| Remover brain | Remove skill + atualiza routing + playbooks |
| Editar brain existente | Regras, templates, checklist dentro do brain |
| Ajustar routing | Tabela de routing no CLAUDE.md |
| Ajustar pipeline | Sequencia de playbooks no CLAUDE.md |
| Adicionar regra imutavel | Secao de regras no CLAUDE.md |
| Atualizar contexto | .ai/CONTEXT.md (stack, convencoes) |

## Checklist de self-review

- [ ] Nucleo lido e entendido completamente antes de editar?
- [ ] Blast radius identificado e minimizado?
- [ ] Convencoes do nucleo original seguidas?
- [ ] CLAUDE.md atualizado se routing/pipelines mudaram?
- [ ] Validator executado e 13/13 PASS?
- [ ] Memoria do nucleo preservada intacta?
- [ ] Mudancas estruturais confirmadas com usuario?

## Post-condicoes (gate de saida)

- Edicao aplicada no nucleo existente
- Validator passou 13/13 criterios no nucleo editado
- CLAUDE.md consistente com brains, routing e pipelines atuais
- Nenhum arquivo de memoria sobrescrito

## Criterios de handoff

- **Edicao simples (regras, checklist)** → editar + validar. DONE.
- **Edicao estrutural (brain novo/removido)** → confirmar com usuario → editar → validar. DONE.
- **Validator falhou** → corrigir issues e re-validar (max 2 iteracoes)
- **Mudanca requer redesign do nucleo** → sugerir criar nucleo novo via `/workflow-criar`
