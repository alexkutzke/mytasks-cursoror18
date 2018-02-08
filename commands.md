```bash
cd vagrant/trusty32 # ou a pasta onde está a sua máquina virtual
vagrant up
vagrant ssh

cd /vagrant

rails new mytasks
cd mytasks

# Configura o git com suas credenciais
git config --global user.name  "SEU NOME"
git config --global user.email "SEU EMAIL"

#### Criar repositório no seu github ####
git remote add origin https://github.com/USUARIO_GITHUB/REPOSITORIO.git
git push -u origin master

#### Descomentar linha 20 no arquivo Gemfile
bundle install

# Adicione a seguinte linha ao arquivo config/environments/development.rb
config.reload_classes_only_on_change = false

# Inicie o servidor rails
rails s -b 0.0.0.0

#### Aproveite para abrir outro terminar da máquina virtual
cd vagrant/trusty32 # ou a pasta onde está a sua máquina virtual
vagrant up
vagrant ssh

cd /vagrant/mytasks

# Adiciona os arquivos os repositorio git
git add .
git commit -am "Adiciona arquivos iniciais"

rails g scaffold list name:string
rails db:migrate

rails g scaffold task name:string done:boolean list:references
```

Aqui, vamos definir que o campo `done` tem um valor default. Para isso, edite o arquivo da migração criado pelo generate (db/migrate/20180000000000_create_tasks.rb):

```ruby
# db/migrate/20180000000000_create_tasks.rb
class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.boolean :done, default: false ########                   
      t.references :list, foreign_key: true

      t.timestamps
    end
  end
end
```

```bash
git add .
git commit -am "Adiciona modelos"
```

### app/models/task.rb
```ruby
# linha 2
belongs_to :list
```

### app/models/list.rb
```ruby
# linha 2
has_many :tasks
```

### db/seeds.rb
```ruby
List.delete_all
Task.delete_all

lista_mercado = List.create({name: "Mercado"})
lista_trabalho = List.create({name: "Trabalho"})
lista_casa = List.create({name: "Casa"})

lista_mercado.tasks.create([
  {
    name: "Melão"
  },
  {
    name: "Ovos"
  },
  {
    name: "Carne"
  },
  {
    name: "Queijo",
    done: true
  }
  ])

lista_casa.tasks.create([
    {
      name: "Arrumar armário"
    },
    {
      name: "Limpar horta"
    },
    {
      name: "Pagar luz",
      done: true
    }
    ])
```

```bash
rails db:seed
```

```bash
rails g controller welcome index
```

### config/routes.rb
```ruby
Rails.application.routes.draw do
  get 'welcome/index'

  resources :tasks
  resources :lists

	root "welcome#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
```

```bash
git add .
git commit -am "Adiciona seeds e controller root"
```

### app/controllers/welcome_controller.rb
```ruby
class WelcomeController < ApplicationController
  def index
		@lists = List.all
  end
end
```

### app/views/welcome/index.html.erb
```erb
<h1>MyTasks!</h1>

<% unless notice.nil? %>
	<%= notice %>
<% end %>

<p>
	<%= link_to 'Nova lista'.html_safe,
						  new_list_path %>
	<%= link_to 'Nova tarefa'.html_safe,
							new_task_path %>
</p>

<% @lists.each do |list| %>
	<h4><%= list.name %></h4>
	<% if list.tasks.empty? %>
		<p><strong>Nenhuma tarefa nessa lista! :)</strong></p>
	<% else %>
		<table>
			<% list.tasks.each do |task| %>
				<tr>
					<td width="*">
						<%= task.done? ? "[X]" : "[ ]" %>
						<%= task.name %>
					</td>
					<td>
						<%= link_to "Editar", edit_task_path(task) %>
						<%= link_to "Apagar", task, method: :delete, data: { confirm: 'Are you sure?' }, class: "btn btn-danger btn-small" %>
					</td>
				</tr>
			<% end %>
		</table>
	<% end %>
<% end %>
```

Problemas com links e redirecionamentos. Como resolver?

## Seleção da lista na criação de tarefas

### app/views/tasks/_form.html.erb
```ruby
# Altere a linha 26 para
<%= form.collection_select :list_id, List.all, :id, :name,{}, {class: "form-control"} %>
```


### Task toogle
`app/controllers/tasks_controller.rb`
`config/routes.rb`

### Task partial
`app/views/welcome/index.html.erb`
`app/views/tasks/_task.html.erb`

### Links e routes sobrando
`config/routes.rb` "only"

3 redirects em cada controller:
`app/controllers/tasks_controller.rb`
`app/controllers/lists_controller.rb`

### Yarn

#### nodejs
```bash
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
```

#### yarn itself
```bash
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get update && sudo apt-get install yarn
```
