class TodosController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :set_todo, only: [:update, :destroy, :edit]
  def index
    if current_user
      @todos = current_user.todos.order(priority: :desc).order(:status)
    end
  end

  def show
  end

  def edit
    respond_to do |format|

      format.html
    end

    
  end

  def new
    @todo = Todo.new
    respond_to do |format|
      format.html
    end
  end
  
  def create
    @todo = Todo.new(todo_params)
    @todo.user = current_user
    if @todo.save
      respond_to do |format|
        format.turbo_stream 
        format.html { redirect_to todos_path, notice: 'Todo was successfully created.' }
      end
    else
      render json: { error: @todo.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @todo.update(todo_params)
      respond_to do |format|
        format.turbo_stream
        format.html
      end
    end
  end

  def destroy
    @todo.destroy
    respond_to do |format|
      format.turbo_stream 
      format.html 
    end
  end

  def todo_params
    params.require(:todo).permit(:title, :priority, :status).merge(user_id: current_user.id).tap do |todo_params|
      if todo_params[:status] == '0'
        todo_params[:status] = 'pending'
      elsif todo_params[:status] == '1'
        todo_params[:status] = 'completed'
      end
    end
  end


  def set_todo
    @todo = Todo.find(params[:id])
  end
end
