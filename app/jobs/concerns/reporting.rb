module Reporting
  extend ActiveSupport::Concern

  def new_items
    @new_items ||= []
  end

  def updated_items
    @updated_items ||= []
  end

  def unchanged_items
    @unchanged_items ||= []
  end

  def failed_items
    @failed_items ||= []
  end
end