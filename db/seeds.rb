# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
List.delete_all
Task.delete_all
User.delete_all

user1 = User.create(name: "User1", email: "a@a.com", password: "123123")
user2 = User.create(name: "User2", email: "b@b.com", password: "123123")

lista_mercado = List.create({name: "Mercado", user_id: user1.id})
lista_trabalho = List.create({name: "Trabalho", user_id: user1.id})
lista_casa = List.create({name: "Casa", user_id: user2.id})

lista_mercado.tasks << Task.create([
  {
    name: "Melão", user_id: user1.id
  },
  {
    name: "Ovos", user_id: user1.id
  },
  {
    name: "Carne", user_id: user1.id
  },
  {
    name: "Queijo",
    done: true, user_id: user1.id
  }
  ])
lista_mercado.save

lista_casa.tasks << Task.create([
    {
      name: "Arrumar armário", user_id: user2.id
    },
    {
      name: "Limpar horta", user_id: user2.id
    },
    {
      name: "Pagar luz",
      done: true, user_id: user2.id
    }
    ])
lista_casa.save
