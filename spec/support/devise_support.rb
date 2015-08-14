module DeviseSupport
  def company_login
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:company]
      company = create(:company)
      sign_in company
    end
  end
end