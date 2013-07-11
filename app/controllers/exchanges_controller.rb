class ExchangesController < ApplicationController
  def index
    @exchanges = Exchange.all
  end

  def show
    @exchange = Exchange.find(params[:id]) if params[:id]
    if @exchange.nil?
      redirect_to action: :index
    end 
  end
end