class ExchangesController < ApplicationController
  before_filter :find_model

  def index
    @exchanges = Exchange.all
  end

  def show
    if @exchange.nil?
      redirect_to action: :index
    end 
  end

  private
  def find_model
    @exchange = Exchange.find(params[:id]) if params[:id]
  end
end