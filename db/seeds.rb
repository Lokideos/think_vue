# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Staff.create([{ email: 'staff_1_test@test.com', password: '111111' },
              { email: 'staff_2_test@test.com', password: '222222' }])

Client.create(
  [
    {
      email: 'client_1_test@test.com', password: '111111', fullname: 'George Alexandro',
      phone: '+7(999)999-99-99'
    },
    {
      email: 'client_2_test@test.com', password: '222222', fullname: 'Alex Giovani',
      phone: '+7(888)888-88-88'
    }
  ]
)
