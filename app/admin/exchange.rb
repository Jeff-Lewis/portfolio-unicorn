ActiveAdmin.register Exchange do
  index do
    column :id
    column :name, sortable: :name do |exchange|
      link_to exchange.name.upcase, admin_exchange_path(exchange)
    end
    column :created_at
    column :updated_at
    default_actions
  end
end
