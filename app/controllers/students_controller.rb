class StudentsController < ApplicationController
  before_action :require_login

  def index
    @students = current_user.students
  end

  def new
    @student = Student.new
  end

  def create
    @student = current_user.students.build(student_params)
    if @student.save
      redirect_to students_path, notice: "Student added successfully"
    else
      render :new
    end
  end

  def edit
    @student = current_user.students.find(params[:id])
  end

  def update
    @student = current_user.students.find(params[:id])
    if @student.update(student_params)
      redirect_to students_path, notice: "Student updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @student = current_user.students.find(params[:id])
    @student.destroy
    redirect_to students_path, notice: "Student deleted successfully"
  end

  private

  def student_params
    params.require(:student).permit(:name, :subject, :marks)
  end

  def require_login
    unless current_user
      redirect_to login_path, alert: "Please log in first"
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
