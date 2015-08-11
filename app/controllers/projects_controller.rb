class ProjectsController < ApplicationController

  def new
    @project = current_company.projects.new
  end

  def create
    @project = current_company.projects.new(project_params)
    if @project.save
      redirect_to company_path(current_company)
    else
      render 'new'
    end
  end

private

  def project_params
    params.require(:project).permit(:name, :description, :file, :budget, :timeframes, { skill_ids: [] })
  end

end
