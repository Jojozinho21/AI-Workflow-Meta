---
name: workflow-retrospective
description: "Analisa nucleos gerados anteriormente e propoe melhorias nos templates. Ativar para: retrospectiva, melhorar templates, o que aprendemos, analisar nucleos anteriores, otimizar templates."
---

# Workflow Retrospective — Nucleo Workflow

## Papel

Analisa nucleos gerados e propoe melhorias incrementais nos templates baseadas em evidencia.
Funciona como o "feedback loop" do sistema: coleta dados de nucleos existentes, identifica patterns e friccoes, e propoe ajustes pontuais nos templates.

## Pre-condicoes (gate de entrada)

- 3+ nucleos registrados em `nucleos/registry.md`, OU pedido explicito do usuario
- Se ativacao automatica: verificar que nao ha retrospectiva registrada nas ultimas 3 sessoes
- Se dados insuficientes: informar ao usuario e sugerir acumular mais nucleos antes de prosseguir

## Regras — 10 Itens

1. **Pipeline de 4 etapas: Coleta → Diagnostico → Propostas → Aprovacao** — etapas definidas previnem analise superficial e garantem que cada proposta e fundamentada
2. **Coleta: ler registry.md + MEMORY_KNOWLEDGE.md + ultimas sessoes** — sem dados completos, diagnostico sera impreciso e propostas serao baseadas em suposicoes
3. **Diagnostico: categorizar em falhas repetidas (2+ nucleos), friccoes e sucessos** — categorias focam a analise em patterns actionaveis em vez de observacoes avulsas
4. **Max 3 propostas por retrospectiva** — muitas mudancas simultaneas desestabilizam os templates e dificultam atribuir causa se algo quebrar
5. **Cada proposta toca exatamente 1 template** — mudancas cross-template sao dificeis de reverter e aumentam risco de efeitos colaterais
6. **Min 2 evidencias por proposta (nucleos onde o problema ocorreu)** — proposta sem evidencia e especulacao, nao melhoria baseada em dados
7. **NUNCA alterar templates silenciosamente** — mudancas nao aprovadas degradam confianca no sistema e impedem rastreabilidade
8. **NUNCA alterar CLAUDE.md do Nucleo Workflow (Camada 1 imutavel)** — CLAUDE.md so muda via workflow-prompt porque e a base de todo o sistema
9. **Propostas rejeitadas entram em cooldown de 3 sessoes** — re-propor insistentemente irrita o usuario e polui a retrospectiva com itens ja descartados
10. **Registrar TODA proposta (aprovada ou rejeitada) em MEMORY_KNOWLEDGE.md** — historico permite rastrear evolucao dos templates e evitar re-propostas ciclicas

### Procedimento de execucao

Para cada etapa do pipeline:
1. **Coleta**: ler todos os dados listados na regra 2
2. **Diagnostico**: aplicar categorizacao da regra 3, listar findings
3. **Propostas**: formular max 3 propostas seguindo regras 4-6
4. **Aprovacao**: apresentar propostas ao usuario, aguardar decisao

Ordem de execucao: seguir etapas 1-4 sequencialmente.
Nao pular etapas — mesmo que diagnostico pareca obvio.

## Templates de output

### Diagnostico Report

```markdown
## Diagnostico — Retrospectiva

**Data**: YYYY-MM-DD
**Nucleos analisados**: N

### Falhas repetidas (2+ nucleos)
- [pattern]: nucleos [X, Y, Z]

### Friccoes (1 nucleo, mas relevante)
- [friccao]: nucleo [X]

### Sucessos (replicar)
- [pattern positivo]: nucleos [X, Y]
```

### Proposta Format

```markdown
### Proposta N: [titulo curto]
- **Template afetado**: [nome do template]
- **Tipo**: [novo parametro / nova secao / ajuste de wording / nova regra]
- **Mudanca**: [diff concreto — antes vs depois]
- **Evidencia**: [nucleos N e M tiveram problema X]
- **Impacto**: [o que melhora com essa mudanca]
```

## Checklist de self-review

Antes de apresentar propostas, verificar:

- [ ] 4 etapas do pipeline executadas em ordem?
- [ ] Cada proposta tem 2+ evidencias concretas?
- [ ] Max 3 propostas nesta retrospectiva?
- [ ] Cooldown respeitado para propostas rejeitadas anteriormente?
- [ ] Nenhuma proposta altera CLAUDE.md?
- [ ] Diagnostico completo entregue (falhas + friccoes + sucessos)?

## Post-condicoes (gate de saida)

- Propostas apresentadas ao usuario com evidencias e diffs concretos
- Propostas aprovadas: aplicadas nos templates + registradas em MEMORY_KNOWLEDGE.md
- Propostas rejeitadas: registradas em MEMORY_KNOWLEDGE.md com motivo da rejeicao + data de cooldown
- Diagnostico completo entregue independente de haver propostas

## Criterios de handoff

- **Propostas aprovadas e aplicadas** → atualizar MEMORY_KNOWLEDGE.md e MEMORY_SESSIONS.md. DONE.
- **Todas propostas rejeitadas** → registrar rejeicoes com cooldown. DONE.
- **Mudanca estrutural necessaria** (reestruturar skills, pipeline, routing) → sugerir workflow-prompt ao usuario. Retrospectiva nao tem escopo para mudancas arquiteturais.
- **Dados insuficientes para diagnostico** → informar usuario, sugerir acumular mais nucleos. DONE.

## Separacao de escopo: Retrospectiva vs Workflow-Prompt

| Criterio | Retrospectiva | Workflow-Prompt |
|----------|--------------|-----------------|
| Ativacao | Automatica (3+ nucleos) ou explicita | Apenas explicita |
| Escopo | Regras, checklist, exemplos dentro de templates | Estrutura de skills, pipelines, routing |
| Evidencia | Min 2 nucleos com mesmo problema | Decisao deliberada do usuario |
| Exemplo | "Adicionar parametro ao template" | "Criar novo skill" |
| Altera CLAUDE.md | Nunca | Sim, com aprovacao |
