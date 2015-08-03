class TypeCompany < EnumerateIt::Base
  associate_values(
    :team_company  => 0,
    :company => 1
  )
end