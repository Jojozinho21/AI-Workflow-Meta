<!--
  Template: memory-knowledge.tmpl.md
  Gera: .ai/MEMORY_KNOWLEDGE.md para o nucleo alvo
  Limite soft: 100 linhas | Limite hard: 150 linhas

  Parametros: nenhum (estrutura fixa, preenchida durante uso)

  Este arquivo e gerado VAZIO com a estrutura de 5 secoes.
  O conteudo e preenchido progressivamente durante as sessoes de trabalho.
-->

# Conhecimento do Projeto

<!-- LIMITES DE TAMANHO:
     - Soft limit: 100 linhas (ao atingir, comprimir entradas antigas)
     - Hard limit: 150 linhas (ao atingir, OBRIGATORIO comprimir antes de adicionar)
     - Comprimir = mesclar entradas similares, remover decisoes revogadas ha 2+ sessoes -->

## Decisoes Ativas

<!-- Decisoes arquiteturais e tecnicas em vigor.
     Remover decisoes revogadas ha 2+ sessoes.
     Mover decisoes revogadas recentes para Anti-Padroes com contexto. -->

| Decisao | Justificativa | Data | Status |
|---------|---------------|------|--------|
<!-- | [Descricao curta da decisao] | [Por que foi tomada] | YYYY-MM-DD | Ativa/Revogada | -->

## Entidades do Projeto

<!-- Entidades importantes: servicos, modulos, APIs, tabelas, etc.
     Manter atualizado conforme novas entidades sao criadas. -->

| Entidade | Tipo | Detalhe |
|----------|------|---------|
<!-- | [Nome da entidade] | [servico/modulo/api/tabela/etc] | [Descricao curta] | -->

## Padroes Validados

<!-- Padroes que funcionaram bem e devem ser repetidos.
     Formato: - **[Nome do padrao]**: [descricao curta] (validado em [contexto])

     Exemplos reais (remover ao preencher):
     - **Debug por niveis**: log condicional por nivel (debug/info/error) com flag em config,
       permite diagnostico sem recompilar (validado em producao)
     - **Try-catch com fallback**: operacao critica com valor padrao se falhar,
       evita crash total por falha pontual (validado em integracao externa)
     - **Auto-save com dirty flag**: so salva quando dados realmente mudaram,
       reduz carga no banco drasticamente (validado com 50+ jogadores)
     - **Estado volatil de carregamento**: flag isLoading previne acoes durante
       inicializacao, evita NPE e estados inconsistentes (validado em plugin) -->

## Anti-Padroes Descobertos

<!-- Abordagens que falharam e devem ser evitadas.
     Formato: - **[Nome do anti-padrao]**: [o que aconteceu] -> [alternativa correta]

     Exemplos reais (remover ao preencher):
     - **Codificar antes de investigar**: escreveu integracao sem entender API do plugin externo,
       teve que reescrever 3x -> sempre decompilar/investigar antes de codificar
     - **Match por propriedade unica**: comparou objetos complexos por apenas 1 campo,
       causou falsos positivos -> usar 2+ criterios ou identificadores unicos
     - **Ler apos operacao destrutiva**: tentou ler dados de um objeto ja consumido/removido,
       retornou null -> extrair dados ANTES da operacao que os destroi
     - **Dual-access sem sync**: dois caminhos de acesso ao mesmo recurso sem sincronizacao,
       causou inconsistencia -> unificar ponto de acesso ou sincronizar -->

## Issues Conhecidos

<!-- Problemas em aberto que precisam de atencao futura.
     Formato: - **[Issue]**: [descricao] | Severidade: [alta/media/baixa] | Desde: YYYY-MM-DD -->

<!-- Nenhum issue registrado ainda. -->
