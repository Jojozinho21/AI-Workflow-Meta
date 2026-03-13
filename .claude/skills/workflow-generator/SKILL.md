---
name: workflow-generator
description: "Gera todos os arquivos de um nucleo a partir de spec aprovada e templates parametrizados. Ativar para: gerar nucleo, criar arquivos do nucleo, montar workspace, construir segundo cerebro a partir de spec."
---

# Workflow Generator — Nucleo Workflow

## Papel

Pega Nucleo Spec aprovada e gera todos os arquivos de um nucleo completo usando templates parametrizados.
Transforma planejamento em workspace funcional, pronto para uso imediato.

## Pre-condicoes (gate de entrada)

- Nucleo Spec com `Status: Approved` (gerada pelo workflow-architect)
- Templates disponiveis em `templates/` do Nucleo Workflow:
  - `claude-md.tmpl.md` — estrutura do CLAUDE.md
  - `brain-skill.tmpl.md` — anatomia de 7 secoes para cada brain
  - `context.tmpl.md` — contexto do projeto
  - `memory-knowledge.tmpl.md` — schema de decisoes e entidades
  - `memory-sessions.tmpl.md` — formato de log de sessoes
  - `playbooks.tmpl.md` — pipelines de playbooks
- Se spec nao tem Status: Approved → recusar e redirecionar ao workflow-architect
- Se algum template estiver ausente → alertar usuario e listar templates faltantes

## Regras

1. Ler Nucleo Spec COMPLETAMENTE antes de gerar qualquer arquivo — geracao parcial produz nucleo inconsistente
2. Perguntar caminho de destino ao usuario ou inferir: `~/Desktop/Nucleo {{NOME}}/` — gerar no lugar errado e irrecuperavel
3. Criar estrutura de diretorios primeiro: `.claude/skills/`, `.ai/` — arquivos sem diretorio causam erros
4. Gerar CLAUDE.md usando `templates/claude-md.tmpl.md` — DEVE ter < 100 linhas — exceder causa desperdicio de contexto permanente
5. Para cada brain na spec: gerar SKILL.md usando `templates/brain-skill.tmpl.md` — template garante anatomia de 7 secoes consistente
6. Gerar `.ai/CONTEXT.md` usando `templates/context.tmpl.md` com stack da spec — contexto errado desorienta o modelo
7. Gerar `.ai/MEMORY_KNOWLEDGE.md` usando `templates/memory-knowledge.tmpl.md` — schema vazio mas correto
8. Gerar `.ai/MEMORY_SESSIONS.md` usando `templates/memory-sessions.tmpl.md` — formato padrao de log
9. Gerar playbooks e inserir no CLAUDE.md usando `templates/playbooks.tmpl.md` — playbooks fora do CLAUDE.md nao sao lidos automaticamente
10. Descriptions de cada brain DEVEM ter 3+ trigger phrases variadas — sem triggers variados, a auto-invocacao do Claude Code falha
11. Cada regra gerada DEVE incluir WHY inline apos `—` — regras sem justificativa sao ignoradas pelo modelo
12. NUNCA deixar `{{PLACEHOLDER}}` sem preencher — se falta dado na spec, perguntar ao usuario antes de gerar
13. NUNCA gerar TODO, FIXME, ou placeholders vagos — nucleo deve estar pronto para uso imediato
14. Registrar nucleo em `nucleos/registry.md` com data, caminho, qtd de brains, status — nucleo nao registrado e invisivel para retrospectiva
15. Inicializar git no workspace de destino com `.gitignore` e commit inicial — versionamento desde o primeiro momento

## Processo de geracao

### Passo 1: Extrair parametros da spec

Mapear cada campo da Nucleo Spec para os parametros dos templates:

| Campo da Spec | Parametro do Template | Arquivo destino |
|---|---|---|
| Nome do nucleo | `{{WORKSPACE_NAME}}` | `CLAUDE.md` |
| Dominio (descricao) | `{{DOMAIN}}` | `CLAUDE.md`, `CONTEXT.md` |
| Owner | `{{OWNER}}` | `CLAUDE.md` |
| Stack | preenche stack section | `CONTEXT.md` |
| Brains (tabela) | um `brain-skill.tmpl.md` por brain | `.claude/skills/<brain>/SKILL.md` |
| Routing semantico | `{{ROUTING_TABLE}}` | `CLAUDE.md` |
| Playbook pipelines | `{{PLAYBOOKS}}` | `CLAUDE.md` |
| Regras imutaveis | `{{IMMUTABLE_RULES}}` | `CLAUDE.md` |
| Plano de memoria | `{{MEMORY_RULES}}`, `{{MEMORY_POINTERS}}` | `CLAUDE.md` |
| Integracoes | lista de APIs/servicos | `CONTEXT.md` |

Validar que TODOS os parametros foram extraidos antes de comecar a gerar.
Se algum campo estiver vazio ou ambiguo na spec, perguntar ao usuario.

### Passo 2: Gerar na ordem correta

A ordem importa — arquivos posteriores dependem dos anteriores:

1. **Diretorios**: `.claude/skills/<brain>/` (um por brain), `.ai/`
2. **`.ai/CONTEXT.md`** — base de contexto com stack, integracoes, convencoes
3. **`.ai/MEMORY_KNOWLEDGE.md`** — schema vazio com secoes corretas para o dominio
4. **`.ai/MEMORY_SESSIONS.md`** — log vazio com header e formato de entrada
5. **`.claude/skills/<brain>/SKILL.md`** — uma skill completa por brain da spec
6. **`CLAUDE.md`** — por ultimo, porque depende de todos os brains gerados para routing table e playbooks
7. **`.gitignore`** — excluir `.env`, `node_modules/`, `dist/`, e patterns do dominio
8. **`git init`** + commit inicial com mensagem: `feat: nucleo <NOME> gerado via Nucleo Workflow`

### Passo 3: Preencher cada brain skill

Para cada brain na spec, ler `templates/brain-skill.tmpl.md` e preencher:

- **Frontmatter**: name (kebab-case) e description (com 3+ trigger phrases variadas)
- **Papel** (secao 1/7): extrair da coluna Papel da tabela de brains, max 3 frases
- **Pre-condicoes** (secao 2/7): derivar dos gates do pipeline — post-condicao do brain anterior vira pre-condicao deste
- **Regras** (secao 3/7): 10-15 regras especificas do dominio, cada uma com WHY apos `—`
- **Templates de output** (secao 4/7): max 2 templates concretos mostrando formato de saida
- **Checklist de self-review** (secao 5/7): 5-10 items verificaveis (binario sim/nao)
- **Post-condicoes** (secao 6/7): o que deve ser verdadeiro ao finalizar
- **Criterios de handoff** (secao 7/7): para qual brain o fluxo segue em cada cenario

### Passo 4: Montar CLAUDE.md

Usar `templates/claude-md.tmpl.md` e preencher:

- **Identidade**: nome do workspace, owner, dominio
- **Regras Imutaveis**: copiar regras da spec (Camada 1), max 10, cada uma com WHY
- **Routing de Brains**: montar tabela com todos os brains gerados no Passo 3
- **Playbook Pipelines**: copiar pipelines da spec, adicionar `→ atualizar memoria` ao final
- **Inicializacao de Sessao**: max 3 passos (ler memoria, ler contexto, perguntar tarefa)
- **Contexto do Projeto**: ponteiros para `.ai/CONTEXT.md`, `.ai/MEMORY_KNOWLEDGE.md`, `.ai/MEMORY_SESSIONS.md`
- **Memoria — Regras de Escrita**: regras de quando escrever e como comprimir

Validar contagem: se CLAUDE.md > 100 linhas, comprimir secoes ate caber.

### Passo 5: Registrar nucleo

Adicionar entrada em `nucleos/registry.md` do Nucleo Workflow:

```markdown
| {{DATA}} | {{NOME}} | {{CAMINHO}} | {{QTD_BRAINS}} | Generated |
```

### Passo 6: Gerar .gitignore

Criar `.gitignore` adaptado ao dominio do nucleo. Base minima:

```
# Dependencias
node_modules/

# Build
dist/
build/
*.js.map

# Ambiente
.env
.env.*

# OS
.DS_Store
Thumbs.db

# Logs
*.log
```

Adicionar patterns especificos do dominio conforme stack da spec
(ex: `__pycache__/` para Python, `target/` para Rust).

### Passo 7: Escrevendo descriptions com trigger phrases

Cada brain description no frontmatter DEVE incluir 3+ formas variadas que o usuario
pode usar para ativar o brain. Formato:

```yaml
description: "[Frase descritiva]. Ativar para: [trigger1], [trigger2], [trigger3], [trigger4]."
```

Variar entre:
- Verbos diferentes para a mesma acao (criar, construir, montar, gerar)
- Niveis de especificidade (criar bot, novo projeto, implementar do zero)
- Linguagem tecnica e coloquial misturada

Exemplo bom: `"Ativar para: implementar codigo, editar arquivo existente, refatorar, codar feature."`
Exemplo ruim: `"Ativar para: implementar, implementar codigo, implementacao."` (mesma raiz repetida)

## Escalation Points

- Spec com mais de 10 brains → confirmar com usuario que complexidade e intencional
- Dominio requer templates customizados nao existentes → alertar e sugerir criacao via workflow-prompt
- Caminho de destino ja contem arquivos → perguntar se deve sobrescrever ou gerar em caminho alternativo
- Spec referencia integracoes sem detalhes → perguntar ao usuario antes de gerar brain de integracao

## Error Recovery

- Se geracao falha no meio: listar arquivos ja criados e perguntar se continua ou descarta
- Se CLAUDE.md excede 100 linhas: identificar secoes mais longas e comprimir, nunca truncar
- Se template nao preenche corretamente: mostrar o parametro faltante e o template afetado
- NUNCA deixar workspace em estado parcial sem avisar o usuario

## Templates de output

### Exemplo: template bruto vs preenchido

**Template bruto** (`brain-skill.tmpl.md` — trecho do frontmatter e secoes 1-3):

```markdown
---
name: {{BRAIN_NAME}}
description: "{{BRAIN_DESCRIPTION}}"
---

# {{BRAIN_NAME}} — {{DOMAIN}}

## Papel
{{ROLE}}

## Pre-condicoes (gate de entrada)
{{PRECONDITIONS}}

## Regras
{{RULES}}
```

**Preenchido** (brain-dev de um nucleo Discord — mesmo trecho):

```markdown
---
name: brain-dev
description: "Gera e mantem codigo TypeScript para bots Discord
  (discord.js v14+). Ativar para: implementar codigo a partir
  de plano aprovado, editar codigo existente, refatoracoes pontuais."
---

# brain-dev — Discord

## Papel
Gerar e manter codigo TypeScript limpo, tipado, testavel,
alinhado com plano aprovado.

## Pre-condicoes (gate de entrada)
- PLAN.md ou mini-spec com Status: Approved no header
- Ler .ai/CONTEXT.md para stack atual do projeto

## Regras
1. Tipos explicitos em toda assinatura de funcao — nunca
   depender de inferencia em assinaturas publicas
2. Handlers de comando NAO contem logica de negocio — delegam
   a services em src/services/
```

Notar: description tem 3 trigger phrases, regras tem WHY, pre-condicoes sao gates verificaveis.

## Checklist de self-review

Antes de apresentar ao usuario, verificar:

- [ ] Todos os brains da spec tem skills gerados?
- [ ] CLAUDE.md < 100 linhas?
- [ ] Cada skill < 400 linhas?
- [ ] Nenhum `{{PLACEHOLDER}}` sem preencher?
- [ ] Routing table no CLAUDE.md cobre todos os brains?
- [ ] Playbooks referenciam apenas brains existentes?
- [ ] `.ai/` files criados com schema correto?
- [ ] Nucleo registrado em `registry.md`?
- [ ] Todas descriptions tem 3+ trigger phrases?
- [ ] Todas regras tem WHY apos `—`?
- [ ] Git inicializado no destino com commit inicial?

## Post-condicoes (gate de saida)

- Todos os arquivos gerados no workspace de destino
- Self-review checklist completo (todos itens verificados)
- Nucleo registrado em `nucleos/registry.md` com Status: Generated
- Nenhum placeholder `{{...}}` remanescente em nenhum arquivo

### Estrutura gerada esperada

```
~/Desktop/Nucleo {{NOME}}/
├── CLAUDE.md                          (< 100 linhas)
├── .gitignore
├── .claude/
│   └── skills/
│       ├── brain-a/SKILL.md           (< 400 linhas cada)
│       ├── brain-b/SKILL.md
│       └── .../SKILL.md
├── .ai/
│   ├── CONTEXT.md
│   ├── MEMORY_KNOWLEDGE.md
│   └── MEMORY_SESSIONS.md
└── nucleos/
    └── registry.md                     (entrada adicionada)
```

### Formato da entrada no registry.md

```markdown
## Registro de Nucleos

| Data | Nome | Caminho | Brains | Status |
|------|------|---------|--------|--------|
| YYYY-MM-DD | Nome do Nucleo | ~/Desktop/Nucleo Nome/ | N | Generated |
```

## Criterios de handoff

- Apos geracao completa → workflow-validator (para validacao de qualidade)
- Se spec incompleta ou ambigua → voltar para workflow-architect com feedback especifico
- Se usuario pedir ajustes pos-geracao → iterar nos arquivos afetados e re-validar checklist
- Se template inadequado para o dominio → alertar e escalar para workflow-prompt
- Se validacao posterior encontrar problemas → receber feedback do workflow-validator e corrigir
