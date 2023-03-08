class Shout < ApplicationRecord
  belongs_to :user
  belongs_to :content, polymorphic: true
#  default_scope {order(created_at: :desc)} this has been commented in order to remember that the timeline  order in Timeline model removed this default scope
  delegate :username, to: :user
end
