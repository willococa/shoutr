class Shout < ApplicationRecord
  belongs_to :user
  validates :body, presence: true, length:  {in: 1..144}
  validates :body, presence: true
end
