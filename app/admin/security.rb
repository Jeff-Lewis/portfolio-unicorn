ActiveAdmin.register Security do

  scope :all, default: true
  # 1 scope per exchange
  Exchange.all.each do |exchange|
    scope exchange.name.upcase do |securities|
      securities.where(:exchange_id => exchange.id)
    end
  end

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
