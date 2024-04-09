Como Utilizar:

1- Instalar o ruby na maquina
2- Instalar o sinatra -> gem install sinatra
3- Instalar o sqlite3 -> gem install sqlite3
4- executar o programa -> ruby ./index.rb

Rotas: 
  GET http://localhost:8080/alunos - Imprime todos os alunos disponiveis na base de dados
  POST http://localhost:8080/alunos - Insere um aluno na base de dados
  PUT http://localhost:8080/alunos/:id - Altera os dados do aluno utilizando o id do mesmo
  DELETE http://localhost:8080/alunos/:id - Exclue um aluno utilizando o id do mesmo
