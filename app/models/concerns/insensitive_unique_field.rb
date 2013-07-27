module InsensitiveUniqueField
  extend ActiveSupport::Concern

  module ClassMethods
    def insensitive_unique(field, *args)
      options = args.extract_options!

      uniqueness_validation = options[:uniqueness] || { case_sensitive: false }
      validation_options = {
        presence: true,
        uniqueness: uniqueness_validation 
      }
      validates field, validation_options

      before_save "make_#{field}_lowercase".to_sym

      define_method("make_#{field}_lowercase") do
        self.send(field).downcase! unless self.send(field).nil?
      end
      
    end

  end
end