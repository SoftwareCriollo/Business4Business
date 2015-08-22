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

  def notification_create_account(email: nil)
    @email = email

    mail(to: @email, subject: 'B4B: You have created an account on B4B. Enjoy it.')
  end

  def notification_new_project_company(company: nil, project: nil)
    @company = company
    @project = project

    mail(to: @company.email, subject: 'B4B: You created a project B4B.')
  end

  def notification_new_project_admin(company: nil, project: nil)
    @company = company
    @project = project

    mail(to: ENV["TO_MAILER"], subject: 'B4B: Project created a B4B.')
  end

end