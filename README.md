# SQFLITE_BancoDeDados - Aplicativo Flutter

Este projeto é um aplicativo Flutter que gerencia uma lista de usuários, permitindo o cadastro, edição e visualização de detalhes dos mesmos.



https://github.com/DvdMeneses/SQFLITE_BancoDeDados-Flutter/assets/115294207/3e10ebed-e2db-45a1-b5e8-74db7af99c6f




## Funcionalidades Implementadas

### TelaHome

- Apresenta uma lista de usuários cadastrados.
- Permite visualizar detalhes de um usuário com um toque simples.
- Permite editar um usuário com um toque longo.
- Possui um ícone na AppBar para acessar a TelaInfo.

### TelaCadastro 

- Permite o cadastro de novos usuários.
- Realiza controle de case (maiúsculo ou minúsculo) e validação para não permitir campos vazios.

### TelaCadastro e TelaAltera

- Permite a edição de usuários existentes.
- Realiza controle de case (maiúsculo ou minúsculo) e validação para não permitir campos vazios.

### TelaDetalhes

- Exibe os detalhes de um usuário.

### TelaInfo

- Fornece informações sobre os desenvolvedores do aplicativo.
- Possui um link para acesso ao GitHub dos desenvolvedores.

## Uso do SQFLITE

O SQFLITE foi utilizado para gerenciar o banco de dados dos usuários.

## Estrutura do Projeto

- `lib/`
  - `domain/`: Contém a classe `Usuario`.
  - `helpers/`: Contém o helper para interação com o banco de dados (`usuario_helper.dart`).
  - `ui/`: Contém as diferentes telas do aplicativo.
  - `info_Page.dart`: Widget com informações sobre os desenvolvedores do aplicativo.

