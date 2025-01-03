class Liste < ApplicationRecord
  has_many :todos, dependent: :destroy
  validates :listname, presence: true
end
