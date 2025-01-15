class Liste < ApplicationRecord
  belongs_to :user
  has_many :todos, dependent: :destroy
  validates :listname, presence: true
end
