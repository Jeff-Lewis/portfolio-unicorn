class SecuritiesController < ApplicationController

  def index
    @exchange = Exchange.find(params[:exchange_id])
    @securities = @exchange.securities
  end

  def show
    @security = Security.find(params[:id]) if params[:id]
    if @security.nil?
      redirect_to action: :index
    end 
  end

end