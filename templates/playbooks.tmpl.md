<!--
  Template: playbooks.tmpl.md
  Gera: Conteudo da secao "Playbook Pipelines" do CLAUDE.md
  Este conteudo e inserido diretamente na secao Playbooks do claude-md.tmpl.md

  Parametros:
    {{PIPELINES}} — Lista de pipelines. Cada pipeline contem:
      - name: Nome do pipeline (ex: "Bot Novo", "Feature", "Bug Fix")
      - sequence: Sequencia de brains em notacao -> (ex: "architect -> dev -> testing")
      - gates: Condicoes de gate entre brains (opcionais)

  Formato de entrada esperado para {{PIPELINES}}:
    [
      {
        "name": "Nome do Pipeline",
        "sequence": "brain-a -> brain-b -> brain-c -> DONE",
        "gates": "condicao opcional entre etapas"
      }
    ]
-->

{{PIPELINES}}

<!-- FORMATO DE GERACAO POR PIPELINE:

     **[Nome do Pipeline]:** brain-a -> brain-b -> brain-c -> DONE -> atualizar memoria

     Se houver gates condicionais, usar colchetes inline:
     **[Nome]:** brain-a -> brain-b -> [gate: condicao] -> brain-c -> DONE -> atualizar memoria

     Exemplos de pipelines comuns:

     **Projeto Novo:** architect -> dev -> testing -> ops -> DONE -> atualizar memoria
     **Feature:** architect -> dev -> testing -> DONE
     **Bug Fix:** testing -> dev -> testing -> DONE
     **Refactoring:** architect -> dev -> testing -> DONE
     **Hotfix:** dev -> testing -> DONE

     Exemplos de gates condicionais:

     **Deploy:** dev -> testing -> [gate: todos testes passam] -> ops -> DONE
     **Integracao:** architect -> integration -> [gate: API funcionando] -> dev -> testing -> DONE

     REGRAS:
     - Todo pipeline termina com DONE
     - Apos DONE, sempre incluir "atualizar memoria" (exceto pipelines triviais)
     - Gates sao auto-enforced pelas pre/post-condicoes de cada brain skill
     - Incluir nota sobre atualizacao de memoria ao final de qualquer playbook
-->

<!-- Ao final de qualquer playbook: atualizar .ai/MEMORY_KNOWLEDGE.md e .ai/MEMORY_SESSIONS.md. -->
