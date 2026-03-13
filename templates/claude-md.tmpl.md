<!--
  Template: claude-md.tmpl.md
  Gera: CLAUDE.md para o nucleo alvo
  Target: < 100 linhas no output gerado

  Parametros:
    {{WORKSPACE_NAME}}  — Nome do workspace/nucleo (ex: "Segundo Cerebro de Discord")
    {{DOMAIN}}           — Descricao do dominio em 1-2 frases
    {{OWNER}}            — Nome do operador/dono do workspace
    {{IMMUTABLE_RULES}}  — Lista numerada de regras imutaveis, cada uma com justificativa (WHY)
    {{ROUTING_TABLE}}    — Linhas da tabela de routing: | Tipo de tarefa | Skill |
    {{PLAYBOOKS}}        — Pipelines em notacao compacta (brain -> brain -> DONE)
    {{INIT_PROTOCOL}}    — Passos de inicializacao de sessao (max 3 passos + ponteiros de arquivo)
    {{MEMORY_POINTERS}}  — Lista de ponteiros para arquivos de contexto/memoria
    {{MEMORY_RULES}}     — Regras de escrita de memoria (durante sessao + fim de sessao)
-->

# {{WORKSPACE_NAME}}

## Identidade

Este workspace e o {{WORKSPACE_NAME}}.
Operado por {{OWNER}}. Dominio: {{DOMAIN}}.

## Regras Imutaveis (Camada 1)

Estas regras tem precedencia absoluta. Nenhuma skill ou arquivo de contexto pode sobrescreve-las.

{{IMMUTABLE_RULES}}

<!-- Gerar regras numeradas. Formato por regra:
     N. NUNCA/SEMPRE [acao] — [justificativa curta do WHY]
     Manter max 10 regras. Cada regra em 1 linha. -->

## Routing de Brains

Ao receber uma tarefa, identifique o tipo e use a skill correspondente:

| Tipo de tarefa | Skill |
|----------------|-------|
{{ROUTING_TABLE}}

<!-- Cada linha: | descricao curta do tipo de tarefa | nome-do-brain | -->

## Playbook Pipelines

Cada playbook define a sequencia de brains. Gates sao auto-enforced pelas
pre/post-condicoes de cada brain skill.

{{PLAYBOOKS}}

<!-- Formato por pipeline:
     **Nome:** brain-a -> brain-b -> brain-c -> DONE -> atualizar memoria
     Ao final de qualquer playbook: atualizar memoria. -->

## Inicializacao de Sessao

{{INIT_PROTOCOL}}

<!-- Max 3 passos numerados. Formato:
     1. Ler [arquivo] — [acao com o conteudo]
     2. Ler [arquivo] — [acao com o conteudo]
     3. Perguntar: "[pergunta de routing]" -> routing table -> ativar brain -->

> NAO fazer: apresentacao longa, listar brains, arte ASCII, perguntas genericas.
> O usuario ja conhece o sistema. Ir direto ao trabalho.

## Contexto do Projeto

{{MEMORY_POINTERS}}

<!-- Formato por ponteiro:
     - Descricao: `caminho/relativo/ARQUIVO.md` -->

## Memoria — Regras de Escrita

{{MEMORY_RULES}}

<!-- Incluir duas subsecoes:
     **Durante a sessao:** bullets de quando escrever imediatamente vs acumular
     **Ao final da sessao:** bullets de compressao, atualizacao, limites

     Regras obrigatorias:
     - Informacao nova contradiz existente -> flag ao usuario, nunca sobrescrever
     - Comprimir sessao em max 5 bullets
     - Manter ultimas 10 sessoes detalhadas
     - Sessoes mais antigas -> comprimir em 1 linha na secao Arquivo -->
