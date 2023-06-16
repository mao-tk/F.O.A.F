# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: ENV['ADMIN_EMAIL'],
  password: ENV['ADMIN_PASSWORD']
)

User.create!(
  [
    {
      email: 'x.ri.mm.s@gmail.com',
      password: '123456',
      name: 'mike'
    }
  ]
)

User.create!(
  [
    {
      email: 'x.ri.s@softbank.ne.jp',
      password: '123456',
      name: 'まお'
    }
  ]
)

10.times do |n|
  User.create!(
    [
      {
        email: "customer#{n}@gmail.com",
        password: '123456',
        name: "ユーザー#{n}"
      }
    ]
  )
end

User.all.each do |user|
  user.posts.create!(
    title: 'タイトル',
    body: 'テキストテキストテキストテキスト'
  )
  user.folders.create!(
    name: 'マイリスト'
  )
end