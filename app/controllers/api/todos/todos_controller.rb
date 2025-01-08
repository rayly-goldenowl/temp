class Api::Todos::TodosController < ApplicationController
  respond_to :json
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  before_action :validate_todo_params, only: [:create, :update]
  before_action :set_todo, only: [:create, :update, :delete]

  
  def index
    @todos = Todo.all
  end

  def show
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      render json: { todo: @todo }, status: :created
    else
      render json: { error: @todo.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @todo.update(todo_params)
      render json: { todo: @todo }, status: :ok, notice: 'Todo was successfully updated.'
    else
      render json: { error: @todo.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @todo.nil?
      render json: { notice: "Not found #{params[:id]}" }, status: :not_found
    else
      Todo.destroy_by(id: params[:id])
      render json: { notice: 'Todo was successfully delete'}, status: :ok
    end
  end

  private
  def todo_params
    if params[:todo][:status] == '0'
      params[:todo][:status] = 'pending'
    else
      params[:todo][:status] = 'completed'
    params.require(:todo).permit(:title, :priority).merge(user_id: current_user.id).merge(status: params[:todo][:status])
  end

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def validate_todo_params
    if params[:todo][:status].blank? || !Todo.statuses.keys.include?(params[:todo][:status])
      render json: { error: "Invalid status" }, status: :unprocessable_entity and return
    end

    if params[:todo][:priority].blank? && !Todo.priorities.keys.include?(params[:todo][:priority])
      render json: { error: "Invalid priority" }, status: :unprocessable_entity and return
    end

    if params[:todo][:title].blank?
      render json: { error: "Title can't be blank" }, status: :unprocessable_entity and return
    end
  end
end
  