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
