# frozen_string_literal: true

class ProductBacklogItem < ApplicationRecord

  validates :product_id, uniqueness: { scope: [:backlog_item_id] }
  validates :backlog_item_id, uniqueness: { scope: [:product_id] }
  # validates :position, uniqueness: { scope: [:product_id] }, numericality: { only_integer: true }, allow_nil: true
  validates :position, numericality: { only_integer: true }, allow_nil: true

  # Association
  belongs_to :product, inverse_of: :product_backlog_items
  belongs_to :backlog_item, inverse_of: :product_backlog_item

  # Scopes
  scope :ordered_by_position, -> { order(position: :asc) }

  acts_as_list scope: :product, top_of_list: 0, add_new_at: nil

  # OVERRIDE - TESTING
  # rubocop:disable all
  def set_list_position(new_position, raise_exception_if_save_fails=true)
    write_attribute position_column, new_position
    raise_exception_if_save_fails ? save! : save
  end
  # rubocop:enable all

end
