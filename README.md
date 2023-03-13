## Passos para executar localmente

- rvm install 3.1.3
- bundle install
- rake db:setup
- rails s

## Sobre

O objetivo dessa aplicação é ser um e-commerce onde concessionárias podem expor e vender seus veículos, e pessoas podem encontrar e comprar esses veículos (essa funcionalidade ainda não existe e não vamos nos preocupar com ela agora). Para que isso seja possível precisamos de dois tipos de usuários:

- Admin: dono da aplicação, responsável por manter o e-commerce, cadastrando/editando novos usuários e concessionárias.
- Dealership: dono de uma concessionária que deseja usar o e-commerce para expor/vender seus veículos.


## Desafio

### Criar cadastro de usuários
- Deve conter obrigatoriamente nome, email, senha e papel (admin ou dealership).
- Um usuário dealership precisa estar obrigatoriamente associado a uma concessionária.
	- Ex: Usuário João é um funcionario da concessionária Gambato veículos.

### Criar sign in/sign out
- Todas as rotas da página de usuários devem ser autenticadas
- Todas as rotas da página de concessionárias devem ser autenticadas
- Todas as rotas da página de veículos, exceto pela index (que deve ser aberta), devem ser autenticadas
- Uma vez que o usuário está logado, a página deve mostrar o nome do usuário e um link para fazer logout

### Internacionalização
- Internacionalizar todas as páginas em dois idiomas: Inglês e Portugues.
- Adicionar um link que possibilite a troca de idioma.
- Na listagem de veículos, adicionar a data de criação (created_at) no seguinte formato:
	- Português: 22 de Janeiro de 2023, às 17:45
	- Inglês: January 22, 2023 17:45
- Na listagem de veículos, adicionar um contador de veículos existentes (no final da página), no seguinte formato:
	- Português:
		- 0: Lista de veículos vazia
		- 1: 1 veículo
		- 2 ou mais: N veículos
	- Inglês
		- 0: Empty vehicles list
		- 1: 1 vehicle
		- 2 ou mais: N vehicles

### Criar autorização (fazer SOMENTE se todos os outros itens estiverem concluídos e sobrar tempo)
- Autorização por página
	- User: todas as rotas devem ser acessadas apenas por um usuário do tipo admin
	- Dealerships: todas as rotas devem ser acesas apenas por um usuário do tipo admin
	- Vehicles
		- a rota index deve ser aberta ao público (e-commerce)
		- as demais rotas devem ser acessadas apenas por um usuário do tipo dealership
		- quando for um usuário do tipo dealership, a página index deve mostrar apenas os veículos da concessionária associada ao usuário
