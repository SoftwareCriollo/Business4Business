class CompanyDecorator < Draper::Decorator
  delegate_all

  def picture_url
    pic = object.pictures.default_pic.last
    if pic.nil?
      ActionController::Base.helpers.image_path("default_img.png")
    else
      pic.file_url
    end
  end

  def name_capitalize
    object.name.capitalize
  end
end
