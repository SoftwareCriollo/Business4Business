class ProjectDecorator < Draper::Decorator
  delegate_all

  def skills
    helpers.content_tag :span, class: 'time' do
      object.skills.map(&:name).join(' | ')
    end
  end

  def company_name
    object.company.name
  end

  def description
    object.description.truncate(80)
  end

end