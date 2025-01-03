class DropOldTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :listes
  end
end
