class MainController < ApplicationController
  before_action :allowed
  def index
    if logged_in
      redirect_to "/#{@selected_list_id}"
    end
  end
  def lists
    @selected_list_id = params[:list_id]
    @lists = List.where(user_id: @user.id)
    @todos = Todo.where(list_id: @selected_list_id)
  end

  def add_list
    list = List.new(name: params[:list_name], user_id: params[:user_id])
    if list.save
      flash[:msg] = 'List Created successfully'
      redirect_to "/#{list.id}"
    else
      flash[:error] = "Couldn't create List"
      redirect_to "/#{@selected_list_id}"
    end
  end

  def change_list
    list = List.find_by(id: params[:list_id])
    list.name = params[:list_name]
    if list.save
      flash[:msg] = 'Name Changed'
      redirect_to "/#{list.id}"
    else
      flash[:error] = "Couldn't create List"
      redirect_to "/#{list.id}"
    end
  end

  def delete_list
    list = List.find_by(id: params[:list_id])
    if list.name == current_user.name
      flash[:error] = "Default List can't be deleted"
      redirect_to "/#{@selected_list_id}"
    else
      list.destroy
      if List.find_by(id: params[:list_id]).nil?
        @selected_list_id = nil if @selected_list_id == params[:list_id]
        flash[:msg] = 'List Deleted'
        redirect_to root_path
      else
        flash[:error] = 'List Not Deleted'
        redirect_to "/#{@selected_list_id}"
      end
    end
  end

  def add_todo
    todo = Todo.new(title: params[:title], body: params[:body], deadline: params[:deadline], completed: false, list_id: params[:list_id])
    if todo.save
      flash[:msg] = 'Todo Added successfully'
      redirect_to "/#{@selected_list_id}"
    else
      flash[:error] = 'Error occurred while adding todo'
      redirect_to "/#{@selected_list_id}"
    end
  end

  def change_todo
    todo = Todo.find_by(id: params[:id])
    todo.title = params[:title]
    todo.body = params[:body]
    todo.deadline = params[:deadline]
    if todo.save
      flash[:msg] = 'Todo Changed successfully'
      redirect_to "/#{@selected_list_id}"
    else
      flash[:error] = 'Error occurred while changing todo'
      redirect_to "/#{@selected_list_id}"
    end
  end

  def toggle_todo_status
    todo = Todo.find_by(id: params[:todo_id])
    todo.completed = !todo.completed
    todo.save
    if todo.save
      redirect_to "/#{@selected_list_id}"
    else
      flash[:error] = 'Error occurred while changing todo'
      redirect_to "/#{@selected_list_id}"
    end
  end

  def delete_todo
    todo = Todo.find_by(id: params[:todo_id])
    todo.destroy
    if Todo.find_by(id: params[:todo_id]).nil?
      flash[:msg] = 'Todo Deleted'
      redirect_to "/#{@selected_list_id}"
    else
      flash[:error] = 'Todo Not Deleted'
      redirect_to "/#{@selected_list_id}"
    end
  end
  
  private

  def allowed
    if logged_in
      @user = User.find_by(id:session[:user_id])
      if @selected_list_id.nil?
        @selected_list_id = List.find_by(user_id: @user.id, name: @user.name).id
      end
    else
      redirect_to '/signin'
    end
  end
end