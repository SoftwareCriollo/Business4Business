module ApplicationHelper
  def cp(path)
    current_route = Rails.application.routes.recognize_path(path)
    "none" if current_page?(path) or params[:controller] == current_route[:controller]
  end

  def path_for_dashboard
    if current_company.is_team_company?
      team_company_dashboard_path
    else
      company_dashboard_path
    end
  end

  def current_company_has_payment?
    current_company.fee_paid?
  end

  def current_company_has_complete_profile?
    if current_company.complete_profile?
      path_for_dashboard
    else
      edit_company_path(current_company)
    end
  end
end
