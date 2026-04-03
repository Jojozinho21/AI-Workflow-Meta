---
name: workflow-business
description: "Intake e descoberta para criar workflows operacionais para empresas e negócios. Ativar para: criar workflow para empresa, workflow empresarial, otimizar processos, melhorar produtividade, workflow de negócios, criar SOP, mapear processo, workflow para time, automação de processo."
---

# workflow-business — Intake Empresarial

## Papel

Coleta o perfil completo da empresa e suas necessidades antes de qualquer design de workflow.
Gera uma **Business Workflow Spec** estruturada que alimenta o workflow-architect com contexto real do negócio.
Nunca pula para o design sem entender primeiro quem é a empresa e qual problema precisa resolver.

## Pre-condicoes (gate de entrada)

- Usuario descreveu que quer um workflow para uma empresa ou negócio
- Se descricao vaga: fazer perguntas de descoberta antes de iniciar
- Se usuario ja forneceu contexto rico da empresa: extrair e estruturar, sem repetir perguntas

## Perguntas de descoberta (ate 5, escolher as mais criticas)

Nunca fazer todas — selecionar as que eliminam mais ambiguidade para o caso concreto:

1. **Setor**: "Qual o segmento da empresa?" (varejo, SaaS, saúde, consultoria, educação, indústria, agência, RH...)
2. **Tamanho**: "Quantas pessoas no time que vai usar o workflow?" (solo, 2-10, 10-50, 50+)
3. **Processo alvo**: "Qual processo ou área quer otimizar?" (vendas, onboarding, atendimento, produção de conteúdo, financeiro, recrutamento...)
4. **Dor atual**: "Qual o maior problema hoje nesse processo?" (lento, inconsistente, sem rastreabilidade, depende de uma pessoa só...)
5. **Ferramentas existentes**: "Quais ferramentas o time já usa?" (Notion, Trello, HubSpot, planilhas, WhatsApp, Slack...)

Perguntar em bloco (uma mensagem) — nunca uma por vez para nao cansar o usuario.

## Regras

1. SEMPRE entender a empresa antes de desenhar qualquer workflow — workflow genérico nao resolve problema real
2. Classificar o tipo de workflow pelo processo alvo:
   - **Operacional**: fluxo repetitivo com passos definidos (onboarding, atendimento, producao)
   - **Decisório**: fluxo com gates de aprovacao e ramificacoes (compras, contratacao, lancamento)
   - **Estratégico**: ciclo de planejamento e revisao (OKRs, sprints, retrospectivas)
   — tipo errado gera workflow com estrutura inadequada para o uso real
3. Mapear QUEM executa cada etapa (agentes humanos) — workflow sem dono de etapa nao é executado
4. Identificar QUANDO o workflow dispara (trigger) — sem trigger claro, o workflow nao tem entrada definida
5. Identificar o OUTPUT esperado — sem output claro, o usuario nao sabe quando o workflow terminou
6. NUNCA assumir ferramentas nao confirmadas — integrar com ferramenta que a empresa nao usa e retrabalho
7. Se empresa usa ferramentas específicas: adaptar o workflow para o ecossistema existente — trocar ferramenta é barreira de adocao
8. Classificar complexidade do workflow:
   - **Simples** (3-5 etapas, 1-2 agentes): processo linear, sem ramificações
   - **Medio** (6-10 etapas, 2-4 agentes): ramificações condicionais, aprovações
   - **Complexo** (10+ etapas, 4+ agentes): multiplos times, integrações, sub-workflows
9. NUNCA gerar o workflow neste skill — apenas a spec — separar descoberta de design previne retrabalho
10. Se usuario pediu workflow para multiplos processos: gerar uma spec por processo, nao misturar

## Processo de descoberta

### Passo 1: Extrair contexto da empresa

Coletar e estruturar:
- **Setor**: segmento de mercado
- **Tamanho do time**: quantas pessoas usam o workflow
- **Processo alvo**: qual area ou atividade
- **Dor principal**: o que nao funciona hoje
- **Ferramentas em uso**: stack operacional existente
- **Objetivo do workflow**: o que muda quando o workflow funcionar bem

### Passo 2: Mapear o processo atual (as-is)

Mesmo que seja disfuncional, entender como fazem hoje:
- Quem inicia o processo? (trigger)
- Quais sao os passos principais?
- Quem esta envolvido em cada passo?
- Onde o processo trava ou falha?
- O que indica que o processo terminou? (output)

### Passo 3: Definir o processo ideal (to-be)

Com base nas dores identificadas:
- Quais etapas devem existir?
- Quem e responsavel por cada etapa?
- Quais gates de aprovacao sao necessarios?
- Quais metricas indicam sucesso?
- Quais automacoes sao possiveis nas ferramentas existentes?

### Passo 4: Gerar Business Workflow Spec

```markdown
# Business Workflow Spec: {{NOME_DO_WORKFLOW}}

**Empresa**: {{SETOR}} — {{TAMANHO}}
**Processo**: {{PROCESSO_ALVO}}
**Tipo**: Operacional / Decisório / Estratégico
**Complexidade**: Simples / Médio / Complexo
**Status**: Draft

## Contexto
- **Dor atual**: {{DOR_PRINCIPAL}}
- **Objetivo**: {{O_QUE_MUDA_QUANDO_FUNCIONAR}}
- **Ferramentas**: {{LISTA_DE_FERRAMENTAS}}

## Agentes (quem executa)
| Agente | Papel no workflow |
|--------|------------------|
| {{AGENTE_1}} | {{PAPEL}} |

## Trigger
{{O_QUE_DISPARA_O_WORKFLOW}}

## Etapas
| # | Etapa | Agente | Input | Output | Gate |
|---|-------|--------|-------|--------|------|
| 1 | {{ETAPA}} | {{AGENTE}} | {{INPUT}} | {{OUTPUT}} | {{APROVACAO_OU_CONDICAO}} |

## Métricas de sucesso
- {{METRICA_1}}: {{BASELINE}} → {{META}}

## Integrações com ferramentas
- {{FERRAMENTA}}: usado em {{ETAPA}}
```

## Templates de output

### Exemplo: Spec para workflow de onboarding de clientes (SaaS)

```markdown
# Business Workflow Spec: Onboarding de Clientes

**Empresa**: SaaS B2B — 15 pessoas
**Processo**: Customer Success — Onboarding
**Tipo**: Operacional
**Complexidade**: Médio
**Status**: Draft

## Contexto
- **Dor atual**: Onboarding inconsistente — cada CS faz diferente, clientes ficam perdidos nas primeiras semanas
- **Objetivo**: Padronizar os primeiros 30 dias, reduzir churn precoce em 30%
- **Ferramentas**: HubSpot (CRM), Notion (docs), Slack (comunicacao), Zoom (calls)

## Agentes
| Agente | Papel no workflow |
|--------|------------------|
| CS Manager | Responsavel pelo onboarding e ponto de contato principal |
| Produto | Conduz demonstracao tecnica e configuracao inicial |
| Financeiro | Valida contrato e acesso ao sistema |

## Trigger
Cliente assina contrato no HubSpot (deal move para "Fechado Ganho")

## Etapas
| # | Etapa | Agente | Input | Output | Gate |
|---|-------|--------|-------|--------|------|
| 1 | Kickoff call agendado | CS Manager | Notificacao HubSpot | Convite Zoom enviado | — |
| 2 | Kickoff call realizado | CS Manager + Produto | Contexto do cliente | Ata + plano 30 dias no Notion | Cliente confirma plano |
| 3 | Configuracao tecnica | Produto | Credenciais do cliente | Ambiente configurado | CS valida acesso |
| 4 | Treinamento basico | CS Manager | Ambiente configurado | Gravacao + checklist de uso | Cliente completa checklist |
| 5 | Check-in dia 15 | CS Manager | NPS parcial | Acoes corretivas (se necessario) | — |
| 6 | Review dia 30 | CS Manager | Metricas de uso | Relatorio de saude do cliente | — |

## Métricas de sucesso
- Time-to-first-value: 14 dias → 7 dias
- Churn precoce (0-90 dias): 15% → 10%
- NPS pos-onboarding: 6 → 8
```

## Checklist de self-review

- [ ] Setor, tamanho e processo alvo identificados?
- [ ] Dor atual documentada com especificidade?
- [ ] Ferramentas existentes listadas?
- [ ] Agentes humanos mapeados com papeis claros?
- [ ] Trigger do workflow definido?
- [ ] Etapas tem input, output e gate definidos?
- [ ] Metricas de sucesso quantificadas (baseline → meta)?
- [ ] Complexidade classificada corretamente?
- [ ] Nenhum placeholder {{}} vazio na spec?

## Post-condicoes (gate de saida)

- Business Workflow Spec gerada com Status: Draft
- Todos os campos preenchidos (sem placeholders)
- Spec apresentada ao usuario para revisao
- Status muda para Approved SOMENTE com confirmacao explicita do usuario

## Criterios de handoff

- **Spec aprovada pelo usuario** → workflow-architect (para design detalhado do workflow)
- **Usuario quer ajustes na spec** → iterar e reapresentar
- **Usuario quer multiplos workflows** → gerar uma spec por processo, handoff em lote para architect
- **Processo muito complexo para um workflow só** → sugerir dividir em sub-workflows, cada um com spec propria
