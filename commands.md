```bash
cd vagrant/trusty32 # ou a pasta onde está a sua máquina virtual
vagrant up
vagrant ssh

cd /vagrant

rails new mytasks --skip-coffee
cd mytasks

# Configura o git com suas credenciais
git config --global user.name  "SEU NOME"
git config --global user.email "SEU EMAIL"

#### Criar repositório no seu github ####
git remote add origin git@github.com:USUARIO_GITHUB/REPOSITORIO.git
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

```
