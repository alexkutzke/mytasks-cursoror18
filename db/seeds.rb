# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
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
