class ProjectsController < ApplicationController
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
      redirect_to company_path(current_company), notice: 'Project created successfully'
    else
      render 'new'
    end
  end

  def update
    if @project.update(project_params)
      redirect_to company_path(current_company), notice: 'Edit project sucessfully'
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

private

  def project_params
    params.require(:project).permit(:name, :description, :file, :budget, :timeframes, { skill_ids: [] })
  end

  def find_project
    @project = Project.find(params[:id])
  end
end
