# Ruby on Rails Code Interview

Sistema desenvolvido para avaliação técnica com Ruby on Rails. O projeto abrange correções de filtros, paginação com cursor, CRUD, envio de e-mails, relatórios com background jobs e testes automatizados.

## Regras
1. **fazer fork do projeto para seu github**
2. **atualizar a versão do ruby e do rails**
3. **criar o dockerfile e o docker-compose**
4. **enviar o link do seu repositório para avaliação**
5. **não usar IA, e nem copiar de outros projetos, nesse caso será desclassificado**

---

## ⚙️ Funcionalidades

1. **Correção de filtros**
   - Filtro por empresa corrigido para retornar apenas usuários da empresa especificada.
   - Filtro por nome de usuário ajustado para permitir buscas parciais e case-insensitive com `ILIKE`.

2. **Teste dos filtros**
   - RSpec com cobertura de casos de uso para filtros de usuários.

3. **Tweets com paginação por cursor**
   - `GET /tweets`: lista tweets ordenados por mais recentes com paginação baseada em cursor.
   - `GET /users/:user_id/tweets`: mesma lógica aplicada para tweets de um usuário.

4. **CRUD de Empresas**
   - CRUD completo com páginas HTML (`CompaniesController`).

5. **Mailer de novo usuário**
   - E-mail enviado automaticamente ao cadastrar novo usuário.

6. **Relatório em segundo plano**
   - Relatório gerado com um service/repository usando Sidekiq (`ReportGenerationJob`).

7. **Cobertura de testes**
   - Cobertura extraída com SimpleCov. Relatório em `coverage/index.html`.

8. **Gerar um relatório com QUERY RAW usando joins, e otimizando a query com indices**
   - aqui você pode criar as tabelas e indices que você achar melhor para demostrar suas habilidades.

9. **utilização de hotwire ou stimulus**
   - aqui é para você mostrar seu conhecimento de ambos.

---

## ▶️ Como rodar

1. **Clone o repositório:**

   ```sh
   git clone https://github.com/seu-usuario/coding-interview.git
   cd coding-interview
   ```

2. **Copie o arquivo de variáveis de ambiente (se necessário):**

   ```sh
   cp .env.example .env
   ```

3. **Suba os containers do Docker:**

   ```sh
   docker-compose up --build
   ```

4. **Instale as gems dentro do container:**

   ```sh
   docker-compose run --rm web bundle install
   ```

5. **Crie e migre o banco de dados:**

   ```sh
   docker-compose run --rm web rails db:create db:migrate
   ```

6. **(Opcional) Popule o banco com seeds:**

   ```sh
   docker-compose run --rm web rails db:seed
   ```

7. **Acesse a aplicação:**

   - No navegador, acesse: [http://localhost:3000](http://localhost:3000)

8. **Para rodar o Sidekiq (jobs em background):**

   ```sh
   docker-compose up sidekiq
   ```

---
**Resumo:**  
- Todos os comandos acima devem ser executados na raiz do projeto.
- O acesso padrão é via [http://localhost:3000](http://localhost:3000).
- Para rodar testes, veja a seção "Como testar" abaixo.


## Como testar

1. **Execute todos os testes automatizados com RSpec:**

   ```sh
   docker-compose run --rm web bundle exec rspec
   ```

2. **Verifique o relatório de cobertura de testes:**

   Após rodar os testes, será gerado um relatório em `coverage/index.html`.  
   Para visualizar, abra o arquivo no navegador:

   ```sh
   open coverage/index.html
   ```

3. **Rode testes de uma área específica:**

   - Apenas os testes de requests:
     ```sh
     docker-compose run --rm web bundle exec rspec spec/requests
     ```
   - Apenas os testes de um model:
     ```sh
     docker-compose run --rm web bundle exec rspec spec/models/user_spec.rb
     ```
   - Apenas um teste específico (linha 15 do arquivo):
     ```sh
     docker-compose run --rm web bundle exec rspec spec/models/user_spec.rb:15
     ```

4. **Dicas importantes:**
   - Sempre rodar os testes dentro do container Docker.
   - Certificar de que o banco de dados de teste está criado e migrado. Se necessário, rodar:
     ```sh
     docker-compose run --rm web rails db:create db:migrate RAILS_ENV=test
     ```
   - O relatório de cobertura é atualizado a cada execução dos testes.
   - Se adicionar novas gems de teste, rode novamente `docker-compose run --rm web bundle install`.