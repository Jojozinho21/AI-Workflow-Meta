<!--
  Template: brain-skill.tmpl.md
  Gera: SKILL.md para cada brain do nucleo alvo
  Target: 150-300 linhas no output gerado
  Anatomia padrao: 7 secoes obrigatorias

  Parametros:
    {{BRAIN_NAME}}        — Identificador kebab-case do brain (ex: "brain-architect")
    {{BRAIN_DESCRIPTION}} — Descricao curta para o frontmatter YAML (1-2 frases)
    {{DOMAIN}}            — Dominio do nucleo pai (para contextualizar o papel)
    {{ROLE}}              — Descricao do papel do brain (2-3 frases max)
    {{PRECONDITIONS}}     — Lista de pre-condicoes (gate de entrada)
    {{RULES}}             — Lista numerada de regras com justificativa (WHY)
    {{OUTPUT_TEMPLATES}}  — Max 2 templates de output com exemplos concretos
    {{SELF_REVIEW}}       — Itens de checklist de self-review (- [ ] formato)
    {{POSTCONDITIONS}}    — Lista de post-condicoes (gate de saida)
    {{HANDOFF_CRITERIA}}  — Criterios de handoff para outros brains
-->

---
name: {{BRAIN_NAME}}
description: "{{BRAIN_DESCRIPTION}}"
---

# {{BRAIN_NAME}} — {{DOMAIN}}

<!-- ============================================================
     SECAO 1/7: PAPEL
     Descrever O QUE este brain faz e QUANDO deve ser ativado.
     Max 3 frases. Sem detalhes de implementacao aqui.
     ============================================================ -->

## Papel

{{ROLE}}

<!-- ============================================================
     SECAO 2/7: PRE-CONDICOES (gate de entrada)
     Lista de condicoes que DEVEM ser verdadeiras antes de iniciar.
     Se alguma pre-condicao falhar, o brain NAO executa.
     Formato: bullets simples, cada um verificavel.
     ============================================================ -->

## Pre-condicoes (gate de entrada)

{{PRECONDITIONS}}

<!-- Formato por pre-condicao:
     - [Condicao verificavel]
     - Se [situacao]: [acao alternativa antes de prosseguir]

     Exemplos de pre-condicoes comuns:
     - Plano/spec aprovado pelo usuario
     - Leitura de arquivos de contexto
     - Perguntas de esclarecimento se descricao vaga -->

<!-- ============================================================
     SECAO 3/7: REGRAS
     Lista numerada. Cada regra TEM que incluir justificativa (WHY).
     Formato: N. ACAO — justificativa
     Max 15 regras. Priorizar as mais criticas primeiro.
     ============================================================ -->

## Regras

{{RULES}}

<!-- Formato por regra:
     1. NUNCA/SEMPRE [acao concreta] — [WHY: justificativa curta]
     2. [Acao] — [WHY]
     ...

     Diretrizes:
     - Verbos fortes no inicio (NUNCA, SEMPRE, verificar, validar, delegar)
     - Justificativa explica a CONSEQUENCIA de nao seguir a regra
     - Agrupar regras relacionadas em sequencia
     - Se precisar de sub-items, usar indent com - -->

<!-- ============================================================
     SECAO 4/7: TEMPLATES DE OUTPUT
     Max 2 templates concretos mostrando o formato de saida esperado.
     Usar blocos de codigo com a linguagem correta.
     Templates devem ser exemplos reais, nao abstratos.
     ============================================================ -->

## Templates de output

{{OUTPUT_TEMPLATES}}

<!-- Formato por template:
     ### Template N: [Nome descritivo]

     ```[linguagem]
     [Conteudo do template com placeholders entre colchetes]
     ```

     Regras para templates:
     - Max 2 templates por brain
     - Mostrar estrutura completa, nao fragmentos
     - Placeholders entre [colchetes] para partes variaveis
     - Se template grande (50+ linhas), colocar em references/ e referenciar aqui -->

<!-- ============================================================
     SECAO 5/7: CHECKLIST DE SELF-REVIEW
     Lista de verificacao que o brain executa ANTES de apresentar
     o resultado ao usuario. Todos os items devem ser verificaveis.
     ============================================================ -->

## Checklist de self-review

Antes de apresentar ao usuario, verificar:

{{SELF_REVIEW}}

<!-- Formato por item:
     - [ ] [Pergunta ou afirmacao verificavel]

     Diretrizes:
     - 5-10 items por checklist
     - Cada item deve ser binario (sim/nao)
     - Ordenar do mais critico ao menos critico
     - Incluir items especificos do dominio -->

<!-- ============================================================
     SECAO 6/7: POST-CONDICOES (gate de saida)
     Condicoes que DEVEM ser verdadeiras quando o brain termina.
     Se alguma post-condicao falhar, o brain NAO faz handoff.
     ============================================================ -->

## Post-condicoes (gate de saida)

{{POSTCONDITIONS}}

<!-- Formato por post-condicao:
     - [Condicao verificavel que deve ser verdadeira ao finalizar]

     Post-condicoes comuns:
     - Artefato gerado (documento, codigo, plano)
     - Status do artefato (Draft vs Approved)
     - Checklist de self-review completo
     - Compilacao/validacao sem erros -->

<!-- ============================================================
     SECAO 7/7: CRITERIOS DE HANDOFF
     Define PARA ONDE o fluxo vai apos este brain.
     Formato condicional: Se [condicao] -> [brain destino]
     ============================================================ -->

## Criterios de handoff

{{HANDOFF_CRITERIA}}

<!-- Formato por criterio:
     - Apos [condicao/evento] -> [brain-destino] ([motivo curto])
     - Se [situacao especial] -> [brain-alternativo] ([motivo])

     Diretrizes:
     - Cobrir o caminho feliz (handoff padrao)
     - Cobrir caminhos alternativos (erros, dependencias)
     - Cobrir caminho de retorno (quando algo falha downstream)
     - Referenciar brains pelo nome exato do routing table -->
