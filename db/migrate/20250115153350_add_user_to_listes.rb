class AddUserToListes < ActiveRecord::Migration[7.1]
  def change
    add_reference :listes, :user, null: false, foreign_key: true
  end
end
