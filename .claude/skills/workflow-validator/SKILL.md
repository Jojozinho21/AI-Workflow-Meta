---
name: workflow-validator
description: "Valida qualidade e consistencia de nucleos gerados. Ativar para: validar nucleo, checar qualidade, revisar nucleo gerado, verificar consistencia, auditar nucleo."
---

# Workflow Validator — Nucleo Workflow

## Papel

Valida qualidade e consistencia de nucleos gerados aplicando 17 itens de verificacao sistematica.
Funciona como o "critico" no protocolo Generator-Critic: recebe nucleo gerado, audita contra padroes, e aprova ou devolve com issues.

## Pre-condicoes (gate de entrada)

- Nucleo gerado (arquivos existem no caminho de destino)
- Caminho do nucleo disponivel no `nucleos/registry.md` ou informado pelo usuario
- Se caminho nao encontrado: perguntar ao usuario antes de prosseguir

## Regras — 17 Itens de Verificacao

1. **CLAUDE.md < 100 linhas** — contar com `wc -l`. Se exceder: identificar secoes que podem ser compactadas ou movidas para skills — porque cada linha extra consome contexto em toda conversa
2. **Cada skill < 400 linhas** — contar cada SKILL.md. Se exceder: sugerir mover conteudo para `references/` — porque skills longas diluem a atencao do modelo
3. **Frontmatter correto em cada skill** — verificar delimiters `---`, campos `name` e `description` presentes — porque frontmatter invalido impede a descoberta automatica da skill
4. **Description com 3+ trigger phrases distintas** — contar frases de ativacao variadas na description — porque auto-invocacao depende de match semantico com a description
5. **Zero duplicacao de regras entre CLAUDE.md e skills** — comparar regras numeradas, flaggear overlap — porque duplicacao cria ambiguidade quando versoes divergem
6. **Pre-condicoes em cada brain** — verificar secao "Pre-condicoes" existe em cada SKILL.md — porque sem gate de entrada, o brain pode ser ativado fora de contexto
7. **Post-condicoes em cada brain** — verificar secao "Post-condicoes" existe — porque sem gate de saida, output nao validado passa para o proximo brain
8. **Checklist de self-review em cada brain** — verificar secao com itens `- [ ]` — porque self-review e a primeira linha de defesa contra erros
9. **Routing cobre todos brains** — extrair brains do routing table no CLAUDE.md e comparar com skills existentes em `.claude/skills/` — porque brain nao mapeado nunca e ativado
10. **Playbooks referenciam brains existentes** — extrair nomes dos playbooks e verificar contra skills — porque pipeline com brain inexistente quebra o fluxo
11. **Memoria com schema rigido** — verificar MEMORY_KNOWLEDGE.md usa tabelas markdown e bullets, nao paragrafos — porque paragrafos nao sao parseveis para retrospectiva
12. **Nenhum placeholder/TODO** — buscar `{{`, `TODO`, `FIXME`, `placeholder` em todos arquivos (exceto `templates/`) — porque placeholders significam geracao incompleta
13. **Regras com WHY** — verificar que regras numeradas tem justificativa apos `—` — porque regras sem razao sao ignoradas pelo modelo
14. **Cada brain tem secao "Racionalizacoes a Rejeitar"** — verificar secao existe em cada SKILL.md — WHY: previne atalhos perigosos
15. **Cada brain tem secao "Limiares de Escalacao"** — verificar secao existe em cada SKILL.md — WHY: previne loops infinitos
16. **Self-review exige evidencia verificavel** — verificar que itens de self-review incluem instrucao de como verificar — WHY: self-review sem evidencia e teatro
17. **Nucleo tem install.sh funcional** — verificar que install.sh existe na raiz e e executavel — WHY: skills sem installer nao sao descobertas

### Procedimento de verificacao

Para cada item:
1. Executar a verificacao descrita
2. Registrar PASS ou FAIL
3. Se FAIL: documentar o problema especifico e sugerir fix concreto

Ordem de execucao: seguir numeracao 1-17 sequencialmente.
Nao pular itens — mesmo que falhas anteriores sejam graves.

## Templates de output

### Validation Report

```markdown
## Validation Report — {{NUCLEO_NAME}}

**Data**: YYYY-MM-DD
**Status**: PASSED / FAILED (N/17)

### Resultados
| # | Item | Status | Detalhe |
|---|------|--------|---------|
| 1 | CLAUDE.md < 100 linhas | PASS/FAIL | X linhas |
| 2 | Skills < 400 linhas | PASS/FAIL | skill-x: Y linhas |
| 3 | Frontmatter correto | PASS/FAIL | — |
| 4 | Description 3+ triggers | PASS/FAIL | skill-x: N triggers |
| 5 | Zero duplicacao | PASS/FAIL | — |
| 6 | Pre-condicoes | PASS/FAIL | skill-x: ausente |
| 7 | Post-condicoes | PASS/FAIL | skill-x: ausente |
| 8 | Checklist self-review | PASS/FAIL | skill-x: ausente |
| 9 | Routing completo | PASS/FAIL | brain-x nao mapeado |
| 10 | Playbooks validos | PASS/FAIL | — |
| 11 | Memoria schema rigido | PASS/FAIL | paragrafos encontrados |
| 12 | Nenhum placeholder | PASS/FAIL | arquivo:linha |
| 13 | Regras com WHY | PASS/FAIL | regra N sem WHY |
| 14 | Racionalizacoes a Rejeitar | PASS/FAIL | skill-x: ausente |
| 15 | Limiares de Escalacao | PASS/FAIL | skill-x: ausente |
| 16 | Self-review com evidencia | PASS/FAIL | skill-x: sem instrucao |
| 17 | install.sh funcional | PASS/FAIL | ausente/nao executavel |

### Issues (se houver)
- **Item N**: [descricao do problema] → [sugestao de fix]
```

## Checklist de self-review

Antes de entregar o report, verificar:

- [ ] Todos os 17 itens verificados sistematicamente?
- [ ] Cada FAIL tem detalhe especifico (nao generico)?
- [ ] Cada falha tem sugestao de fix concreta e acionavel?
- [ ] Report completo entregue (tabela + issues)?
- [ ] Nenhum item pulado ou marcado sem verificacao real?

## Post-condicoes (gate de saida)

- 17/17 passando → nucleo aprovado, pronto para ativacao
- Issues encontrados → lista de falhas com sugestoes de fix entregue
- Report completo gerado no formato padrao (tabela + issues)
- Resultado registrado: PASSED ou FAILED com contagem

## Criterios de handoff

- **17/17 PASS** → nucleo aprovado. Atualizar `nucleos/registry.md` com Status: Active. DONE.
- **Issues encontrados** → devolver lista para workflow-generator (max 2 iteracoes internas entre generator e validator)
- **Apos 2 iteracoes ainda com falhas** → escalar ao usuario com issues especificos e sugestoes
- **Falha apos escalation** → nucleo fica com Status: Failed no registry, usuario decide proximo passo
