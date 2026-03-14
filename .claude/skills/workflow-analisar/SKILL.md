---
name: workflow-analisar
description: "Analisa e audita nucleos de AI existentes. Ativar para: analisar nucleo, auditar workflow, revisar nucleo, checar qualidade, diagnosticar nucleo, avaliar nucleo, validar nucleo existente."
---

# /workflow-analisar — Analisar Nucleo

## Papel

Ponto de entrada para analise e auditoria de nucleos de AI existentes.
Le o nucleo, executa validacao de 13 criterios, e entrega relatorio com findings e sugestoes.

## Pre-condicoes (gate de entrada)

- Nucleo existente com caminho informado pelo usuario ou disponivel em `nucleos/registry.md`
- Se caminho nao encontrado: perguntar ao usuario
- Se usuario descreveu sintoma especifico (ex: "brain X nunca ativa"): focar analise nessa area

## Fluxo

```
📊 INVENTARIO              → Lista brains, routing, pipelines, memoria, templates
🔍 VALIDACAO 13 CHECKS     → workflow-validator audita contra 13 criterios
🏗️ ARQUITETURA             → Analisa coerencia de routing, pipelines, gates
🧠 MEMORIA                 → Verifica schema, consistencia, uso correto
📋 RELATORIO               → Findings com severidade (CRITICAL/WARNING/INFO)
```

## Regras

1. LER o nucleo COMPLETAMENTE antes de analisar — analise parcial produz diagnostico incompleto
2. SEMPRE executar os 13 checks do validator como base — validacao padronizada garante cobertura minima
3. Ir ALEM dos 13 checks: analisar coerencia arquitetural — validator checa forma, analise checa substancia
4. Categorizar findings por severidade — sem categorizacao, usuario nao sabe o que priorizar:
   - **CRITICAL**: nucleo nao funciona (routing quebrado, brain inexistente referenciado)
   - **WARNING**: nucleo funciona mas tem problemas (regra sem WHY, skill longa, triggers fracos)
   - **INFO**: sugestoes de melhoria (pattern reutilizavel, otimizacao possivel)
5. Cada finding DEVE ter sugestao de fix concreta — finding sem fix e diagnostico sem tratamento
6. Se usuario pediu analise focada (ex: "por que brain X nao ativa"): priorizar essa area mas nao ignorar o resto — sintoma pode ter causa em area diferente
7. NUNCA modificar o nucleo durante analise — analisar e alterar sao escopos diferentes, misturar causa confusao
8. Comparar com patterns de nucleos anteriores no registry — nucleo isolado parece ok, mas comparacao revela divergencias

## Analises extras (alem dos 13 checks)

| Analise | O que verifica |
|:--------|:---------------|
| Coerencia de routing | Toda skill tem entrada no routing? Routing aponta pra skills existentes? |
| Gates de pipeline | Post-condicao do brain N = pre-condicao do brain N+1? |
| Trigger diversity | Descriptions usam verbos variados? Triggers sao semanticamente distintos? |
| Memory usage | MEMORY_KNOWLEDGE tem dados? MEMORY_SESSIONS registra sessoes? |
| Blast radius | Brain com escopo muito amplo? Sobreposicao entre brains? |
| Complexidade | Quantidade de brains compativel com dominio? Over/under-engineering? |

## Templates de output

### Relatorio de Analise

```markdown
## Analise — {{NUCLEO_NAME}}

**Data**: YYYY-MM-DD
**Caminho**: {{CAMINHO}}
**Brains**: {{N}}

### Validacao (13 checks)
| # | Item | Status |
|---|------|--------|
(tabela do validator)

### Findings
#### CRITICAL
- [finding]: [sugestao de fix]

#### WARNING
- [finding]: [sugestao de fix]

#### INFO
- [finding]: [sugestao de fix]

### Resumo
- **Score**: X/13 checks passando
- **Saude geral**: [Saudavel / Precisa atencao / Critico]
- **Proximos passos**: [recomendacoes]
```

## Checklist de self-review

- [ ] Nucleo lido completamente antes de analisar?
- [ ] 13 checks do validator executados?
- [ ] Analises extras executadas (routing, gates, triggers, memoria)?
- [ ] Findings categorizados por severidade?
- [ ] Cada finding tem sugestao de fix concreta?
- [ ] Relatorio completo entregue?
- [ ] Nenhum arquivo do nucleo foi modificado?

## Post-condicoes (gate de saida)

- Relatorio completo entregue com validacao + findings + sugestoes
- Nenhum arquivo do nucleo modificado (read-only)
- Se findings criticos: recomendacao clara de proximos passos

## Criterios de handoff

- **Nucleo saudavel (13/13, sem criticals)** → entregar relatorio. DONE.
- **Issues encontrados** → entregar relatorio com sugestoes. Usuario decide se quer `/workflow-editar`.
- **Nucleo com problemas graves** → sugerir `/workflow-editar` para correcoes ou `/workflow-criar` para recriar.
- **Analise revelou patterns reutilizaveis** → sugerir retrospectiva para incorporar nos templates.
