# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.where(id: 1)
if admin.present?
  admin.email = 'tyler_sampson@tresblue.com'
  admin.password = 'admin1234')
  admin.skip_confirmation!
  admin.save
end

if Bank.count == 0
  %w{ABSA Standard Nedbank FNB}.each do |bank|
    Bank.create name: bank
  end
end

if Status.count == 0
  Status.create name: 'Listing', nature: 'preparation', can_edit: true
  Status.create name: 'Registered', nature: 'closed', can_edit: false
  Status.create name: 'Cancelled', nature: 'closed', can_edit: false
end
