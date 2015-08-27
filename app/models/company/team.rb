class Company::Team < Company
  
  def dashboard_path
    team_company_dashboard_path
  end

end