class Todo < ApplicationRecord
  belongs_to :user
  belongs_to :liste, optional: true

  # https://ruby-china.github.io/rails-guides/active_record_validations.html
  validates :name, presence: true
  validates :done, presence: true, acceptance: { accept: [0, 1], message: '只能为0（未完成）或1（完成）' }
  validates :important, presence: true, acceptance: { accept: [0, 1], message: '只能为0（普通）或1（重要）' }
end
