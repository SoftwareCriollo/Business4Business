ActiveAdmin.register Rate do
  permit_params :amount, :type_company_id

  form do |f|
    f.inputs "Rates" do
      f.input :amount
      f.input :type_company_id, as: :select, collection: TypeCompany.to_a
    end
    f.actions
  end
end