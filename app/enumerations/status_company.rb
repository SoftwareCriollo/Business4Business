class StatusCompany < EnumerateIt::Base
  associate_values(
    :on_hold => 0,
    :approve => 1,
    :reject => 2
  )

  def self.to_h
    to_a.inject({}){ |r, s|  r.merge!({s[0].gsub(' ','_').downcase => s[1]})}
  end
end