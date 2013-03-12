class PortfoliosController < ApplicationController
  before_filter :find_portfolio, :only => [:show, :edit, :update, :destory]

  def index
    @portfolios = Portfolio.all
  end

  def new
    @portfolio = Portfolio.new
  end

  def create
    @portfolio = Portfolio.new(params[:portfolio])
    if @portfolio.save
      flash[:notice] = "Portfolio created."
      redirect_to portfolio_path(@portfolio)
    else
      flash[:alert] = "Portfolio not created."
      render "new"
    end
  end

  def show
    @holdings = @portfolio.holdings.all
    @portfolio.price_updated = Time.at(@portfolio.price_updated).strftime "%Y-%m-%d %H:%M:%S"
  end

  def update_holdings
    @portfolio = Portfolio.find(params[:portfolio_id])
    update_prices(@portfolio.id)

    flash[:notice] = "Prices have been updated! Thanks for waiting."
    redirect_to @portfolio
  end

private
  def update_prices(id)
    `rake portfolio:update[#{id}]`
  end

  def find_portfolio
    @portfolio = Portfolio.find(params[:id])
  end
end
