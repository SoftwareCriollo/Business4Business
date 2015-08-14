class Company::Team < Company

  def is_team_company?
    type_company == TypeCompany::TEAM_COMPANY
  end

  def dashboard_path
    team_company_dashboard_path
  end

end