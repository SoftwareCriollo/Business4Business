class ProjectsController < ApplicationController
  load_and_authorize_resource 
  before_action :authenticate_company!
  before_action :find_project, except: [:new, :create, :index]

  def index
    @q = Project.all.ransack(params[:q])
    @projects = ProjectDecorator.decorate_collection(@q.result)
  end

  def new
    @project = current_company.projects.new
  end

  def create
    @project = current_company.projects.new(project_params)
    if @project.save
      send_email_new_project(@project)
      redirect_to project_path(@project), notice: 'Project created successfully'
    else
      render 'new'
    end
  end

  def update
    if @project.update(project_params)
      redirect_to project_path(@project), notice: 'Edit project sucessfully'
    else
      render 'edit'
    end
  end

  def destroy
    if @project.destroy
      redirect_to company_path(current_company), notice: 'Delete project sucessfully'
    else
      redirect_to company_path(current_company), alert: 'An error has occurred when deleting the project'
    end
  end

  def show
    @company = current_company
  end

  def send_email_new_project(project)
    @company = current_company
    @project = project
    NotificationMailer.notification_new_project_company(company: @company, project: @project).deliver_now
    NotificationMailer.notification_new_project_admin(company: @company, project: @project).deliver_now
  end

private

  def project_params
    params.require(:project).permit(:name, :description, :file, :budget, :timeframes, { skill_ids: [] }, pictures_attributes: pictures_attributes)
  end

  def pictures_attributes
    [
      :id, :file, :default, :_destroy
    ]
  end

  def find_project
    @project = Project.find(params[:id]).decorate
  end
end
