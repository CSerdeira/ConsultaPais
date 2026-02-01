# GeoInfo

Aplicação desenvolvida em **Delphi VCL** para consulta de informações de países a partir de uma API pública, utilizando **TNetHTTPClient**.

## Funcionalidades
- Consulta por nome do país
- Exibição de:
  - Nome oficial
  - Capital
  - Região
  - População
  - Moeda
- Exibição da bandeira do país
- Tratamento de erros (campo vazio, país não encontrado, falha de comunicação)

## Tecnologias utilizadas
- Delphi VCL
- TNetHTTPClient
- THTTPClient
- Manipulação de JSON

## Como executar
1. Abra o projeto no Delphi
2. Compile e execute o arquivo `.dproj`
3. Digite o nome de um país e clique em **Consultar**

## Observações
- Os campos de resultado são somente leitura
- A bandeira é carregada dinamicamente a partir da URL retornada pela API

## Autor
Projeto desenvolvido para fins de estudo e avaliação.
