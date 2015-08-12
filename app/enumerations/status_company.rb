class StatusCompany < EnumerateIt::Base
  associate_values(
    :on_hold => 0,
    :approve => 1,
    :reject => 2
  )
end