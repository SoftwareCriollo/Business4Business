ActiveAdmin.register Skill do
  permit_params :name

  form do |f|
    f.inputs "Skills" do
      f.input :name
    end
    f.actions
  end
end