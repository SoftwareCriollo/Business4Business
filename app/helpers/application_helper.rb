module ApplicationHelper
  def cp(path)
    current_route = Rails.application.routes.recognize_path(path)
    "none" if current_page?(path) or params[:controller] == current_route[:controller]
  end

  def name_class
    if current_company
      ActiveModel::Naming.singular(current_company).to_sym
    else
      company = Company.new(type: params[:company][:type])
      ActiveModel::Naming.singular(company).to_sym
    end
  end
end
