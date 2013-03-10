class HoldingsController < ApplicationController
  before_filter :find_portfolio
  before_filter :find_holding, :only => [:show, :edit, :update, :destroy]

  def new
    @holding = @portfolio.holdings.build
  end

  def create
    @holding = @portfolio.holdings.build(params[:holding])
    if @holding.save
      flash[:notice] = "Holding added."
      redirect_to portfolio_path(@portfolio)
    else
      flash[:alert] = "Holding not added."
      render "new"
    end
  end

private
  def find_portfolio
    @portfolio = Portfolio.find(params[:portfolio_id])
  end

  def find_holding
    @holding = @portfolio.holdings.find(params[:id])
  end
end
