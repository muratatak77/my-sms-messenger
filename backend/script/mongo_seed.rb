puts "🌱 Seeding MongoDB with 2 users and messages..."

User.delete_all
Message.delete_all

# Admin ve demo kullanıcıları
admin = User.create!(username: 'admin', password: 'admin')
demo = User.create!(username: 'demo', password: 'demo')

# Admin için mesajlar
10.times do |i|
  Message.create!(
    to: '+18777804236',
    body: "Admin’s message #{i + 1}",
    status: 'delivered',
    user: admin
  )
end

# Demo kullanıcı için mesajlar
10.times do |i|
  Message.create!(
    to: '+19998887777',
    body: "Demo’s message #{i + 1}",
    status: 'delivered',
    user: demo
  )
end

puts "✅ Done seeding!"
