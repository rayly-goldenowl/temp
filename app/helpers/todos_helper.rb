module TodosHelper
  def completed_count(todos)
    todos.where(status: 'completed').count
  end

  def pending_count(todos)
    todos.where(status: 'pending').count
  end

  def progress_percentage(todos)
    completed_count = todos.where(status: 'completed').count
    completed_count > 0 ? (completed_count.to_f / todos.count * 100).round(2) : 0
  end
end
