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
    {{DOMAIN_PREFIX}}     — Prefixo do dominio do nucleo (ex: "brain", "plugin", "github")
    {{RATIONALIZATION_1}} — Pensamento enganoso #1 que parece razoavel mas leva a erro
    {{WHY_1}}             — Explicacao de por que rationalization #1 esta errada
    {{RATIONALIZATION_2}} — Pensamento enganoso #2
    {{WHY_2}}             — Explicacao de por que rationalization #2 esta errada
    {{RATIONALIZATION_3}} — Pensamento enganoso #3
    {{WHY_3}}             — Explicacao de por que rationalization #3 esta errada
    {{ESCALATION_1}}      — Condicao de escalacao #1 (quando parar e pedir ajuda)
    {{ESCALATION_2}}      — Condicao de escalacao #2
    {{ESCALATION_3}}      — Condicao de escalacao #3
    {{HANDOFF_CRITERIA}}  — Criterios de handoff para outros brains
-->

<!--
  Convencao de Prefixo:
    O prefixo do skill segue o dominio do nucleo:
    - Nucleo de Discord → brain-*   (brain-architect, brain-dev, brain-testing)
    - Nucleo de Plugins → plugin-*  (plugin, plugin-editar, plugin-analisar)
    - Nucleo de GitHub  → github-*  (github-commit, github-readme, github-setup)
    - Nucleo Meta       → workflow-* (workflow-criar, workflow-editar)

    Regra: {{DOMAIN_PREFIX}}-{{BRAIN_NAME}}
    O prefixo e definido pelo workflow-architect na spec do nucleo.
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
     - Perguntas de esclarecimento se descricao vaga

     GATE DE INTEGRACAO (incluir se brain interage com sistemas externos):
     - Antes de codificar integracao, investigar API/contrato do sistema externo
     - Decompilar/ler documentacao ANTES de escrever adapter
     - Validar que o metodo/classe existe na versao em uso
     - Licao: codificar integracao sem investigar causa reescrita multipla -->

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
     SECAO 3.5a: RACIONALIZACOES A REJEITAR
     Lista de pensamentos que parecem razoaveis mas levam a erros.
     ============================================================ -->

## Racionalizacoes a Rejeitar

<!--
  Lista de pensamentos que PARECEM razoaveis mas levam a erros.
  Formato: tabela com 2 colunas.
  Gerar 3-5 racionalizacoes especificas ao dominio do brain.
  WHY: Previne o modelo de tomar atalhos que parecem produtivos mas degradam qualidade.
-->

| Pensamento | Por que esta errado |
|-----------|-------------------|
| {{RATIONALIZATION_1}} | {{WHY_1}} |
| {{RATIONALIZATION_2}} | {{WHY_2}} |
| {{RATIONALIZATION_3}} | {{WHY_3}} |

<!-- ============================================================
     SECAO 3.5b: LIMIARES DE ESCALACAO
     Define quando o brain deve PARAR e pedir ajuda ao usuario.
     ============================================================ -->

## Limiares de Escalacao

<!--
  Define quando o brain deve PARAR e pedir ajuda ao usuario.
  Formato: lista com condicoes concretas e numericas.
  WHY: Previne loops infinitos e decisoes autonomas em situacoes ambiguas.
-->

- {{ESCALATION_1}}
- {{ESCALATION_2}}
- {{ESCALATION_3}}

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

<!--
  IMPORTANTE: Cada item de self-review DEVE exigir evidencia verificavel.
  NAO usar apenas "PASS/FAIL" — incluir instrucao de como verificar.
  Exemplo:
    - [ ] Codigo compila sem erros? (rodar comando e colar output)
    - [ ] Todos os arquivos do plano foram criados? (listar com ls)
    - [ ] Testes passam? (rodar comando e mostrar resultado)
  WHY: Self-review sem evidencia e teatro — nao previne erros reais.
-->

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
     - Referenciar brains pelo nome exato do routing table
     - HANDOFF PROATIVO: se o brain detecta problemas que outro brain resolve,
       OFERECER handoff ativamente em vez de esperar o usuario pedir
       (ex: "Encontrei N problemas. Quer que eu corrija? (ativa brain-X)") -->
