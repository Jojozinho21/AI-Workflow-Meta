# Nucleo Workflow

**Workspace:** Nucleo Workflow
**Owner:** Jonathan Locks
**Dominio:** Meta-workflow para gerar nucleos de AI consistentes e estruturados. Domain-agnostic.

## Regras Imutaveis (Camada 1)

1. NUNCA gerar nucleo sem spec aprovada — nucleos sem planejamento produzem skills incoerentes
2. SEMPRE anatomia de 7 secoes em cada brain skill — consistencia permite comparacao e melhoria sistematica
3. CLAUDE.md gerado DEVE ter < 100 linhas — carregado em toda conversa, cada linha consome contexto permanente
4. Cada skill gerada DEVE ter < 400 linhas — conteudo pesado vai em references/
5. NUNCA duplicar regras entre Camada 1 e Camada 2 — duplicacao cria ambiguidade quando versoes divergem
6. Toda regra gerada DEVE incluir justificativa (WHY) — regras sem razao sao ignoradas pelo modelo
7. Templates so mudam via retrospectiva ou workflow-prompt aprovados — mudancas nao rastreadas degradam qualidade

## Routing de Skills

| Tipo de tarefa | Skill |
|---|---|
| Criar nucleo novo, descrever dominio, planejar nucleo | workflow-architect |
| Gerar arquivos a partir de spec aprovada | workflow-generator |
| Validar nucleo gerado, checar qualidade | workflow-validator |
| Analisar nucleos anteriores, melhorar templates | workflow-retrospective |
| Mudar estrutura do Nucleo Workflow em si | workflow-prompt |

## Playbook Pipelines

**Criar Nucleo:** architect → generator → validator → [fix if issues] → DONE → atualizar memoria
**Melhorar Templates:** retrospective → [proposals] → aprovacao → aplicar → DONE
**Meta-Otimizacao:** workflow-prompt → [proposals] → aprovacao → aplicar → DONE

## Inicializacao de Sessao

1. Ler `.ai/MEMORY_KNOWLEDGE.md` → resumir patterns e anti-patterns em 1-2 linhas
2. Ler `nucleos/registry.md` → quantos nucleos, ultimo gerado
3. Perguntar: "O que criamos hoje?" → routing → ativar skill

> NAO fazer apresentacao longa, listar skills, arte ASCII. Ir direto ao trabalho.

## Contexto do Projeto

- Stack e configuracao: `.ai/CONTEXT.md`
- Decisoes e patterns: `.ai/MEMORY_KNOWLEDGE.md`
- Historico de sessoes: `.ai/MEMORY_SESSIONS.md`
- Templates parametrizados: `templates/`
- Nucleos gerados: `nucleos/registry.md`

## Memoria — Regras de Escrita

### Durante a sessao
- Decisao sobre templates → escrever em MEMORY_KNOWLEDGE.md imediatamente
- Demais (feedback, patterns, issues) → acumular e flush no fim
- Informacao nova contradiz existente → flag ao usuario, nunca sobrescrever

### Fim de sessao
- Comprimir sessao em max 5 bullets → prepend em MEMORY_SESSIONS.md
- Atualizar MEMORY_KNOWLEDGE.md
- Se 3+ nucleos e sem retrospectiva recente → sugerir retrospectiva
