require 'sinatra'
require 'sqlite3'

# Configurando a porta para 8080
set :port, 8080

# Método para estabelecer a conexão com o banco de dados
def db
  SQLite3::Database.new "alunos.db"
end

# Criação da tabela 'alunos' se ela não existir
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS alunos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(255),
    curso VARCHAR(255)
  );
SQL

# Rota para listar todos os usuários
get '/alunos' do
  alunos = db.execute("SELECT * FROM alunos")
  alunos.to_json # convertendo a exibição para json
end

# Rota para criar um novo usuário
post '/alunos' do
  alunos = JSON.parse request.body.read 
  nome = alunos['nome']
  curso = alunos['curso']
  
  db.execute("INSERT INTO alunos (nome, curso) VALUES (?, ?)", [nome, curso])
  
  status 201 # Created
end

# Rota para exibir informações de um usuário específico
get '/alunos/:id' do
  id = params[:id]
  aluno = db.execute("SELECT * FROM alunos WHERE id = ?", id).first
  
  if aluno
    aluno.to_json
  else
    status 404 # Not Found
  end
end

# Rota para atualizar informações de um usuário
put '/alunos/:id' do
  id = params[:id]
  alunos = JSON.parse request.body.read
  nome = alunos['nome']
  curso = alunos['curso']
  
  db.execute("UPDATE alunos SET nome = ?, curso = ? WHERE id = ?", [nome, curso, id])
  
  status 200 # OK
end

# Rota para deletar um usuário
delete '/alunos/:id' do
  id = params[:id]
  
  db.execute("DELETE FROM alunos WHERE id = ?", id)
  
  status 204 # No Content
end
