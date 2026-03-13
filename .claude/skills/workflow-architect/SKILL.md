---
name: workflow-architect
description: "Analisa dominios e gera specs completas para novos nucleos de AI. Ativar para: criar nucleo novo, descrever dominio, planejar nucleo, projetar workflow, definir segundo cerebro, montar sistema de AI."
---

# Workflow Architect — Nucleo Workflow

## Papel

Analisa dominios de qualquer tipo e gera Nucleo Specs completas.
Produz documentos estruturados que descrevem a arquitetura de um novo nucleo de AI.

## Pre-condicoes (gate de entrada)

- Descricao do dominio recebida do usuario (o que o nucleo vai fazer)
- Se descricao vaga: fazer ate 3 perguntas de esclarecimento antes de planejar
- Ler nucleos/registry.md para reusar patterns de nucleos anteriores

### Perguntas de esclarecimento (quando necessario)

Usar ate 3 perguntas focadas para eliminar ambiguidade:
- "Quais sao as 3-5 tarefas principais que o nucleo vai executar?"
- "Qual a stack/tecnologia do projeto?" (linguagem, frameworks, plataformas)
- "Existem integracoes externas obrigatorias?" (APIs, bancos, servicos)
- "Quem e o usuario final? Ele interage via CLI, chat, web?"
- "Existe algum nucleo anterior que serve de referencia?"

NAO perguntar tudo — escolher as 1-3 mais criticas para o dominio descrito.

## Regras

1. Analise de dominio: identificar entidades, acoes, ciclos de trabalho do dominio — sem essa analise, os brains gerados serao genericos e inuteis
2. Classificar complexidade do nucleo:
   - **Simples** (1-3 brains): dominio focado, poucas tarefas
   - **Medio** (4-7 brains): dominio com multiplos workflows
   - **Complexo** (8+ brains): dominio amplo com integracoes e pipelines longos
   — complexidade errada gera nucleo com brains demais ou de menos
3. Cada brain DEVE ter papel unico, triggers distintos, e pre/post-condicoes — brains sem escopo claro se sobrepoe e confundem o routing
4. Routing semantico DEVE cobrir todas as tarefas possiveis do dominio — tarefas nao mapeadas nao ativam nenhum brain
5. Playbook pipelines DEVEM definir sequencia logica com gates entre brains — sem gates, output de um brain passa para o proximo sem validacao
6. Regras imutaveis: 5-10 regras especificas do dominio, cada uma com WHY — regras sem justificativa sao ignoradas pelo modelo
7. NUNCA gerar arquivos neste skill — apenas a spec — porque separar planejamento de execucao previne retrabalho
8. Considerar necessidade de integracoes externas e alertar — integracao nao planejada vira gambiarra
9. Descriptions de cada brain devem ter 3+ trigger phrases variadas — sem triggers variados, a auto-invocacao falha
10. Propor plano de memoria: quais tipos de decisoes, entidades e patterns o nucleo vai persistir — sem memoria planejada, cada sessao comeca do zero
11. Se dominio nao se encaixa nos templates existentes, alertar e sugerir ajustes — forcar um template inadequado gera nucleo fragil
12. Consultar nucleos anteriores no registry para reusar patterns que funcionaram — reinventar patterns validados e desperdicio
13. Definir pre/post-condicoes para CADA brain como gates automaticos — sem gates, brains executam fora de ordem ou sem input necessario
14. Regras imutaveis do nucleo DEVEM ser especificas e acionaveis, nao genericas — regra vaga tipo "manter qualidade" nao muda comportamento do modelo
15. Validar que nenhum brain tem escopo sobreposto com outro — sobreposicao causa routing ambiguo e respostas inconsistentes

## Processo de analise

### Passo 1: Decomposicao do dominio

Antes de montar a spec, decompor o dominio em:

1. **Entidades** — objetos principais que o nucleo manipula (ex: bots, projetos, tarefas, documentos)
2. **Acoes** — operacoes que o usuario executa sobre as entidades (ex: criar, editar, validar, deployar)
3. **Ciclos** — workflows completos do inicio ao fim (ex: criar projeto → desenvolver → testar → deployar)
4. **Restricoes** — limites tecnicos ou de negocio (ex: rate limits de API, formatos obrigatorios)

### Passo 2: Mapeamento de brains

Para cada ciclo identificado:
- Agrupar acoes relacionadas em brains coesos
- Garantir que cada brain tem responsabilidade unica
- Definir fronteiras claras (quando termina um brain e comeca outro)
- Mapear triggers: quais frases do usuario ativam cada brain

### Passo 3: Definicao de routing e pipelines

- Montar tabela de routing cobrindo TODAS as acoes identificadas
- Definir pipelines para cada ciclo completo
- Inserir gates entre brains (pre-condicao do proximo = post-condicao do anterior)
- Validar que nenhuma acao ficou sem brain correspondente

### Passo 4: Regras e memoria

- Extrair regras especificas do dominio (nao genericas)
- Cada regra com justificativa concreta
- Definir quais entidades e decisoes o nucleo deve persistir
- Especificar formato e localizacao da memoria

## Templates de output

### Nucleo Spec Format

```markdown
# Nucleo Spec: {{NOME}}

**Dominio**: {{DOMINIO}}
**Stack**: {{STACK}}
**Complexidade**: Simples/Medio/Complexo
**Status**: Draft/Approved

## Brains
| Brain | Papel | Triggers |
|-------|-------|----------|

## Routing Semantico
| Tipo de tarefa | Brain |
|----------------|-------|

## Playbook Pipelines
{{PIPELINE_1}}: brain1 → brain2 → brain3 → DONE
{{PIPELINE_2}}: ...

## Regras Imutaveis (Camada 1)
1. REGRA — porque JUSTIFICATIVA

## Integracao
- APIs/servicos: {{LISTA}}
- Ferramentas de build: {{LISTA}}

## Memoria
- Entidades: {{TIPOS}}
- Decisoes criticas: {{EXEMPLOS}}
- Formato: MEMORY_KNOWLEDGE.md (decisoes) + MEMORY_SESSIONS.md (historico)
```

### Exemplo de preenchimento: Nucleo Discord

```markdown
# Nucleo Spec: Discord Bot Builder

**Dominio**: Desenvolvimento de bots Discord
**Stack**: TypeScript, discord.js v14, Node.js
**Complexidade**: Complexo
**Status**: Approved

## Brains
| Brain | Papel | Triggers |
|-------|-------|----------|
| brain-architect | Projeta arquitetura antes de codigo | criar bot, planejar feature, projetar arquitetura, novo projeto |
| brain-dev | Implementa codigo a partir de plano | implementar, codar, desenvolver, criar arquivo, escrever codigo |
| brain-testing | Valida qualidade e corrige bugs | bug, erro, testar, code review, validar, crash, stacktrace |
| brain-integration | Conecta APIs e servicos externos | integrar API, conectar banco, configurar webhook |
| brain-ops | Infra, deploy, CI/CD | deploy, docker, CI, logging, monitoramento |

## Routing Semantico
| Tipo de tarefa | Brain |
|----------------|-------|
| Criar bot ou projeto novo | brain-architect |
| Feature nova (2+ arquivos) | brain-architect |
| Implementar plano aprovado | brain-dev |
| Bug fix, erro, crash | brain-testing |
| Code review, validacao | brain-testing |
| Integracao com API externa | brain-integration |
| CI/CD, Docker, deploy | brain-ops |

## Playbook Pipelines
Bot Novo: architect → dev → testing → ops → DONE
Feature: architect → dev → testing → DONE
Bug Fix: testing → dev → testing → DONE
Integracao: architect → integration → testing → DONE

## Regras Imutaveis (Camada 1)
1. NUNCA gerar codigo sem plano aprovado — codigo sem plano gera retrabalho
2. SEMPRE TypeScript com strict: true — sem any, sem excecao
3. NUNCA expor tokens ou secrets em codigo — vazamento de credenciais compromete o bot
4. Todo collector DEVE ter timeout — collectors infinitos causam memory leak
5. Falha de API externa NUNCA derruba o bot — implementar fallback graceful

## Integracao
- APIs/servicos: Discord API, Minecraft RCON
- Ferramentas de build: TypeScript compiler, Vitest

## Memoria
- Entidades: bots, commands, events, intents, permissoes
- Decisoes criticas: escolhas de arquitetura, dependencias adicionadas, intents privilegiados
```

### Brains padrao (presentes em todo nucleo)

Alguns brains aparecem em praticamente todo nucleo. Usar como base e adaptar:

- **brain-architect / brain-planner**: projeta antes de executar
- **brain-dev / brain-builder**: executa o trabalho principal do dominio
- **brain-testing / brain-validator**: valida qualidade do output
- **brain-retrospective**: analisa sessoes e melhora o sistema

Brains especificos do dominio sao adicionados conforme necessidade
(ex: brain-integration, brain-ops, brain-research).

## Checklist de self-review

Antes de apresentar ao usuario, verificar:

- [ ] Todos os brains tem papel e triggers definidos?
- [ ] Routing cobre todas as tarefas possiveis do dominio?
- [ ] Playbooks tem sequencia logica com gates?
- [ ] Regras imutaveis tem justificativa (WHY)?
- [ ] Complexidade classificada corretamente?
- [ ] Status = Draft (usuario ainda nao aprovou)?
- [ ] Nenhum placeholder vazio na spec?
- [ ] Descriptions dos brains tem 3+ trigger phrases?
- [ ] Plano de memoria definido?
- [ ] Consultou nucleos/registry.md para patterns existentes?
- [ ] Nenhum brain com escopo sobreposto?
- [ ] Pre/post-condicoes de cada brain formam gates validos?
- [ ] Integracoes externas identificadas e listadas?

## Post-condicoes (gate de saida)

- Nucleo Spec escrita com conteudo completo (sem placeholders vazios)
- Status = Draft (apresentada ao usuario para revisao)
- Status muda para Approved SOMENTE quando usuario confirma explicitamente
- Nunca mudar status automaticamente
- Spec salva em formato markdown para consumo do workflow-generator

### Fluxo de aprovacao

1. Apresentar spec completa ao usuario
2. Aguardar feedback: aprovacao, pedidos de mudanca, ou rejeicao
3. Se mudancas solicitadas → iterar na spec e reapresentar
4. Se aprovado → marcar Status = Approved
5. Se rejeitado → perguntar o que mudar ou descartar

## Criterios de handoff

- Apos aprovacao do usuario → workflow-generator (para gerar os arquivos do nucleo)
- Se usuario pedir mudancas na spec → iterar ate aprovacao
- Se dominio requer integracoes complexas → alertar antes de aprovar
- Se complexidade parece subestimada → alertar usuario e sugerir reclassificacao
- Se registro mostra nucleo similar ja gerado → perguntar se quer usar como base
