---
name: workflow-prompt
description: "Meta-otimizacao estrutural do Nucleo Workflow. Ativar para: mudar estrutura do sistema, reestruturar skills, alterar pipeline, modificar routing, criar ou remover skills do Nucleo Workflow."
---

# Workflow Prompt — Nucleo Workflow

## Papel

Meta-otimizacao estrutural do Nucleo Workflow. Mudancas deliberadas que afetam a arquitetura do sistema: skills, pipelines, routing, e CLAUDE.md.
Funciona como o "arquiteto do sistema": recebe pedido de mudanca estrutural, analisa impacto, propoe diff concreto, e aplica somente apos aprovacao.

## Pre-condicoes (gate de entrada)

- Pedido explicito do usuario. Este skill NUNCA e ativado automaticamente.
- Se ativado por outro skill (ex: retrospectiva sugeriu mudanca estrutural): confirmar com usuario antes de prosseguir
- Usuario deve descrever a mudanca desejada com clareza suficiente para analise de impacto

## Regras — 7 Itens

1. **Fluxo de 6 etapas: Analise → Impacto → Proposta com diff → Aprovacao → Aplicacao → Documentacao** — etapas previnem mudancas impensadas que podem quebrar o sistema
2. **NUNCA alterar CLAUDE.md sem aprovacao explicita do usuario** — Camada 1 e a base de todo o sistema e mudancas nao autorizadas comprometem todos os nucleos futuros
3. **NUNCA fazer mudancas incrementais em templates individuais** — isso e escopo da retrospectiva, misturar escopos gera confusao sobre qual skill e responsavel por qual tipo de mudanca
4. **NUNCA aplicar mudancas silenciosamente** — transparencia e fundamental em mudancas estruturais porque efeitos colaterais podem ser dificeis de diagnosticar depois
5. **Mapear impacto em todos os skills e templates afetados antes de propor** — mudanca estrutural sem analise de impacto quebra dependencias entre skills e pipelines
6. **Apresentar diff concreto (antes/depois) para cada mudanca** — diff abstrato nao permite avaliacao precisa e leva a aprovacoes mal informadas
7. **Registrar toda mudanca em MEMORY_KNOWLEDGE.md com justificativa** — historico permite entender por que o sistema evoluiu e facilita reverter decisoes ruins

### Procedimento de execucao

Para cada etapa do fluxo:
1. **Analise**: entender o que o usuario quer mudar e por que
2. **Impacto**: listar todos skills, templates e pipelines afetados
3. **Proposta**: apresentar diff concreto (antes/depois) para cada arquivo
4. **Aprovacao**: aguardar aprovacao explicita do usuario
5. **Aplicacao**: aplicar mudancas nos arquivos
6. **Documentacao**: registrar em MEMORY_KNOWLEDGE.md

Ordem de execucao: seguir etapas 1-6 sequencialmente.
NUNCA pular para aplicacao sem aprovacao — mesmo que a mudanca pareca trivial.

## Templates de output

### Proposta de Mudanca Estrutural

```markdown
## Proposta — [titulo da mudanca]

**Data**: YYYY-MM-DD
**Solicitante**: usuario
**Tipo**: [novo skill / remover skill / alterar pipeline / alterar routing / alterar CLAUDE.md]

### Impacto
- **Skills afetados**: [lista]
- **Templates afetados**: [lista]
- **Pipelines afetados**: [lista]

### Diff
**Arquivo**: [caminho]
**Antes**:
[conteudo atual]

**Depois**:
[conteudo proposto]

### Justificativa
[por que essa mudanca e necessaria]
```

## Checklist de self-review

Antes de apresentar proposta, verificar:

- [ ] Impacto mapeado em todos skills/templates afetados?
- [ ] Diff concreto apresentado (antes/depois) para cada arquivo?
- [ ] Aprovacao explicita obtida do usuario?
- [ ] Mudanca documentada em MEMORY_KNOWLEDGE.md?
- [ ] Nenhuma mudanca incremental de template (escopo da retrospectiva)?

## Post-condicoes (gate de saida)

- Mudanca aprovada: aplicada nos arquivos + documentada em MEMORY_KNOWLEDGE.md com justificativa
- Mudanca rejeitada: registrada em MEMORY_KNOWLEDGE.md com motivo da rejeicao
- Commit realizado via git com mensagem descritiva da mudanca estrutural

## Criterios de handoff

- **Mudanca aprovada e aplicada** → documentar em MEMORY_KNOWLEDGE.md, commit via git. DONE.
- **Mudanca rejeitada** → registrar rejeicao com motivo. DONE.
- **Nao ha proximo skill no pipeline** — workflow-prompt e terminal por definicao.
