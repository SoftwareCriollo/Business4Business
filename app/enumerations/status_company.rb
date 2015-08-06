class StatusCompany < EnumerateIt::Base
  associate_values(
    :On_Hold => 0,
    :Approve => 1,
    :Reject => 2
  )

  def self.to_h
    to_a.inject({}){ |r, s|  r.merge!({s[0].gsub(' ','_').downcase => s[1]})}
  end
end