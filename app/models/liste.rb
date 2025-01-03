class Liste < ApplicationRecord
  has_many :listes, dependent: destroy
end
