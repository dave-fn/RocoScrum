# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'database_cleaner'
require 'factory_bot_rails'
require 'faker'

DatabaseCleaner.clean_with :truncation

r1 = FactoryBot.create :scrum_master_role
r2 = FactoryBot.create :product_owner_role
r3 = FactoryBot.create :developer_role

e1 = FactoryBot.create :sprint_event
e2 = FactoryBot.create :sprint_planning_event
e3 = FactoryBot.create :sprint_review_event
e4 = FactoryBot.create :sprint_retrospective_event
e5 = FactoryBot.create :daily_scrum_event

case Rails.env
when 'development'
  u1 = FactoryBot.create :dummy_user, name: 'testuser', email: 'testuser@example.org'
  u2 = FactoryBot.create :user_admin, user: (FactoryBot.create :dummy_user, name: 'testadmin', email: 'testadmin@example.org')
when 'production'
end
