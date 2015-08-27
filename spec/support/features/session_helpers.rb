module Features
  module SessionHelpers
    def sign_in(company)
      visit new_company_session_path
      fill_in 'Email', with: company.email
      fill_in 'Password', with: company.password
      find('.btn').click
    end
  end
end