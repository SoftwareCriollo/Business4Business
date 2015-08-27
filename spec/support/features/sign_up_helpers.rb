module Features
  module SignUpHelpers
    def sign_up_with(company)
      fill_in 'Company Name', with: company.name
      fill_in 'Email', with: company.email
      fill_in 'Password', with: company.password
      fill_in 'Password confirmation', with: company.password
      find('.btn-sign-up-company').click
    end
  end
end