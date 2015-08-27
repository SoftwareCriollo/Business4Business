class TypeCompany < EnumerateIt::Base
  associate_values(
    team_company: 'Company::Team',
    company: 'Company'
  )
end