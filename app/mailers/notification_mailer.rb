class NotificationMailer < ActionMailer::Base

  default from: ENV["FROM_MAILER"]

  def notification_admin(reason: nil, note: nil, company: nil)
    @reason = reason
    @note = note
    @company = company

    mail(to: ENV["TO_MAILER"], subject: 'B4B: A company no longer our friend :(')
  end

  def notification_company(reason: nil, note: nil)
    @reason = reason
    @note = note

    mail(to: ENV["TO_MAILER"], subject: 'B4B: We are no longer friends B4B :(')
  end

end