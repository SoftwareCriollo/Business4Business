class CancelReason < EnumerateIt::Base
  associate_values(
    :i_do_not_like => 0,
  	:i_got_what_i_wanted => 1,
  	:lack_of_time => 2,
  	:lack_of_money => 3,
  	:i_do_not_need_it => 4,
  	:poor_service => 5
  )
end