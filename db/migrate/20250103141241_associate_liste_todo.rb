class AssociateListeTodo < ActiveRecord::Migration[7.1]
  def change
    add_column :todos, :l_id, :integer
    add_index :todos, :l_id
    add_foreign_key :todos, :listes, column: :l_id
  end
end
