module TodosHelper
  def has_liste(l)
    if l
      liste_todos_path(l)
    else
      todos_path
    end
  end
end
