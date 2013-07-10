class SecuritiesController < ApplicationController
  before_filter :find_model

  

  private
  def find_model
    @model = Securities.find(params[:id]) if params[:id]
  end
end