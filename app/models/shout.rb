class Shout < ApplicationRecord
  belongs_to :user
  belongs_to :content, polymorphic: true
  default_scope {order(created_at: :desc)}
  delegate :username, to: :user
end
