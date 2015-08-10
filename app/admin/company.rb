ActiveAdmin.register Company do
  permit_params :id, :name, :description, :category, :tax_id, :address, :logo, :type_company, :website, :status,
                contacts_attributes: [:id, :first_name, :last_name, :email, :phone, :_destroy]

  action_item :view_site do
    link_to "View Site", "/"
  end

  show do |company|
    attributes_table do
      rows :id, :name, :description, :category, :tax_id, :address, :logo, :type_company, :website, :status
    end

    panel 'Contacts' do
      attributes_table_for company.contacts do
        rows :first_name, :last_name, :email, :phone
      end
    end

    panel 'Payments' do
      table_for company.payments do
        column(:amount){ |a| "$#{a.amount / 100}" }
        column('Paid date'){ |val| val.created_at.strftime("%c") }
      end
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :status
    column :company do |company|
      truncate(company.description, omision: "...", length: 100)
    end
    column :website
    column :type_company
    action
  end

  filter :name

  form do |f|
    f.inputs "Companies" do
      f.input :name
      f.input :description, as: :text, input_html: { rows: 4 }
      f.input :category, :as => :select, :collection => Category.all.map{|c| [c.name,c.id]}
      f.input :tax_id
      f.input :address, as: :text, input_html: { rows: 2 }
      f.input :logo
      f.input :type_company, as: :select, collection: TypeCompany.to_a
      f.input :website
      f.input :status, as: :select, collection: StatusCompany.keys
    end
    f.actions
  end

end