<!--
  Template: context.tmpl.md
  Gera: .ai/CONTEXT.md para o nucleo alvo

  Parametros:
    {{STACK}}           — Linguagem, runtime, frameworks principais (ex: "TypeScript, Node.js 20+, discord.js v14")
    {{BUILD_TOOL}}      — Ferramenta de build (ex: "tsc", "esbuild", "vite", "webpack")
    {{TEST_FRAMEWORK}}  — Framework de testes (ex: "vitest", "jest", "mocha", "nenhum")
    {{DATABASE}}        — Banco de dados, se houver (ex: "PostgreSQL via Prisma", "SQLite", "nenhum")
    {{INTEGRATIONS}}    — APIs e servicos externos integrados (ex: "Discord API, OpenAI API, RCON")
    {{CONVENTIONS}}     — Convencoes de codigo e projeto (naming, estrutura de pastas, etc.)
-->

# Contexto do Projeto

## Stack

- **Linguagem/Runtime:** {{STACK}}
- **Build:** {{BUILD_TOOL}}
- **Testes:** {{TEST_FRAMEWORK}}
- **Banco de dados:** {{DATABASE}}

## Integracoes Externas

{{INTEGRATIONS}}

<!-- Formato por integracao:
     - **[Nome da API/Servico]**: [para que e usado] | Docs: [link se disponivel] -->

## Convencoes

{{CONVENTIONS}}

<!-- Convencoes sugeridas a incluir:
     - Estrutura de pastas (src/, tests/, config/, etc.)
     - Naming conventions (camelCase, kebab-case para arquivos, etc.)
     - Padrao de imports (ESM vs CJS, extensao .js, etc.)
     - Padrao de error handling
     - Padrao de logging
     - Padrao de config/env -->

## Estrutura de Pastas

<!-- Gerar tree da estrutura de pastas do projeto.
     Atualizar conforme novas pastas/arquivos sao criados.
     Formato:
     ```
     projeto/
     ├── src/
     │   ├── [pastas principais]
     │   └── index.ts
     ├── tests/
     ├── .ai/
     │   ├── CONTEXT.md
     │   ├── MEMORY_KNOWLEDGE.md
     │   └── MEMORY_SESSIONS.md
     └── package.json
     ``` -->
