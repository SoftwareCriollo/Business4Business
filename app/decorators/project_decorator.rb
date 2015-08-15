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

  def picture_url
    pic = object.pictures.default_pic.last
    if pic.nil?
      ActionController::Base.helpers.image_path("default_img.png")
    else
      pic.file_url
    end
  end
end