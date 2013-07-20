ActiveAdmin.register Security do

  scope :all, default: true

  index do
    column :id
    column :symbol, sortable: :symbol do |security|
      link_to security.symbol.upcase, admin_security_path(security)
    end
    column :name
    column :created_at
    column :updated_at
    default_actions
  end
end
