# frozen_string_literal: true

class ItemStatus < ApplicationRecord

  validates :title, presence: true, uniqueness: { scope: [:team_id, :context] }
  validates :context, presence: true

  belongs_to :team, optional: true, inverse_of: :item_statuses

  # Scopes
  scope :for_product_items, -> { where(context: 'PBI') }
  scope :for_sprint_items, -> { where(context: 'SBI') }

end
