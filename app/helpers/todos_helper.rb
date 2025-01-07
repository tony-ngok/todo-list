module TodosHelper
  def has_liste(l)
    if l
      liste_todos_path(l)
    else
      todos_path
    end
  end

  def model_has_liste(l, todo)
    if l
      [l, todo]
    else
      todo
    end
  end

  def edit_has_liste(l, todo)
    if l
      edit_liste_todo_path(l, todo)
    else
      edit_todo_path(todo)
    end
  end
end
