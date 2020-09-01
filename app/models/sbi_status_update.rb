# frozen_string_literal: true

class SbiStatusUpdate < ApplicationRecord

  # Item & Status
  belongs_to :sprint_backlog_item, inverse_of: :status_updates
  belongs_to :item_status, inverse_of: :sbi_status_updates

  # Users
  belongs_to :developer, class_name: 'User', inverse_of: :sbi_developer_status_updates
  belongs_to :creator, class_name: 'User', inverse_of: :sbi_creator_status_updates

end
