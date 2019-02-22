# frozen_string_literal: true

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

sbis1 = FactoryBot.create :sbi_committed_status
sbis2 = FactoryBot.create :sbi_assigned_status
sbis3 = FactoryBot.create :sbi_in_progress_status
sbis4 = FactoryBot.create :sbi_completed_status
sbis5 = FactoryBot.create :sbi_pending_status

case Rails.env
when 'development'
  u1 = FactoryBot.create :user, name: 'testuser', email: 'testuser@example.org'
  u2 = FactoryBot.create :admin_user, name: 'testadmin', email: 'testadmin@example.org'

  pp = FactoryBot.create_list :project, 3
  p1 = FactoryBot.create :project, :with_sprints, sprint_count: 2, admin: u1
  t1 = FactoryBot.create :working_team, developer_count: 4, project: p1
  t2 = FactoryBot.create :working_team, developer_count: 3, project: pp.first

  prod1 = FactoryBot.create :product, :with_product_owner, :with_backlog_items, project: t1.project
  s1 = FactoryBot.create :sprint, :with_backlog_items, team: t1, project: pp.first

  sbis_t1 = FactoryBot.create :item_status, context: 'SBI', team: t1
when 'production'
end
