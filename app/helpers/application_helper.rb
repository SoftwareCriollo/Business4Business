module ApplicationHelper
  def cp(path)
    current_route = Rails.application.routes.recognize_path(path)
    "none" if current_page?(path) or params[:controller] == current_route[:controller]
  end

  def name_class
    if params[:company].nil?
      'company_team'.to_sym
    else
      'company'.to_sym
    end
  end
end
