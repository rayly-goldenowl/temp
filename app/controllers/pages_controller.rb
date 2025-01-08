class PagesController < ApplicationController
  def index
    if current_user
      @todos = current_user.todos
    end
  end
end
