ActiveAdmin.register Company do
  permit_params :id, :name, :description, :category, :tax_id, :address, :logo, :type, :website, :status,
                contacts_attributes: [:id, :first_name, :last_name, :email, :phone, :_destroy]

  action_item :view_site do
    link_to "View Site", "/"
  end

  action_item :company, only: :show do
    if company.status == StatusCompany::ON_HOLD
      render 'custom_action', company: company
    elsif company.status == StatusCompany::APPROVE
      link_to 'Reject', reject_request_companies_path(company), class: "member_link"
    else
      link_to 'Approve', approve_request_companies_path(company), class: "member_link"
    end
  end

  show do |company|
    panel "Company Details", only: :show do
      attributes_table_for company do
        row('status') { |s| StatusCompany.key_for(s.status).to_s.humanize }
        row :name
        row :description
        row :website
        row :category
        row :address
        row :tax_id
        row('type') { |b| TypeCompany.key_for(b.type).to_s.humanize }
        row :logo
      end
    end

    panel 'Contacts' do
      attributes_table_for company.contacts do
        rows :first_name, :last_name, :email, :phone
      end
    end

    panel 'Payments' do
      table_for company.payments do
        column(:amount){ |a| "$ #{a.amount / 100}" }
        column('Paid date'){ |val| val.created_at.strftime("%c") }
      end
    end

    panel 'Projects' do
      table_for company.projects do
        column(:name)
        column('Description'){ |des| truncate(des.description, omision: "...", length: 100) }
        column(:timeframes)
        column('Budget'){ |val| number_to_currency(val.budget) }
      end
    end
  end

  index row_class: ->company { 'hide' if company.no_active? } do
    selectable_column
    id_column
    column('Status') { |s| StatusCompany.key_for(s.status).to_s.humanize }
    column :name
    column :company do |company|
      truncate(company.description, omision: "...", length: 100)
    end
    column :website
    column('Type') { |type| TypeCompany.key_for(type.type).to_s.humanize }

    actions

    column 'Manage' do |company|
      div do
        if company.status == StatusCompany::ON_HOLD
          render 'custom_action', company: company
        elsif company.status == StatusCompany::APPROVE
          link_to 'Reject', reject_request_companies_path(company), class: "member_link"
        else
          link_to 'Approve', approve_request_companies_path(company), class: "member_link"
        end
      end
    end
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
      f.input :type, as: :select, collection: TypeCompany.to_a
      f.input :website
      f.input :status, as: :select, collection: StatusCompany.to_a
    end
    f.actions
  end

end