class RenameLidToListeid < ActiveRecord::Migration[7.1]
  def change
    rename_column :todos, :l_id, :liste_id
  end
end
